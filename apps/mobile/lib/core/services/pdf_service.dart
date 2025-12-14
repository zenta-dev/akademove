import 'dart:typed_data';

import 'package:api_client/api_client.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// Service for generating PDF documents
class PdfService {
  PdfService();

  /// Currency formatter for Indonesian Rupiah
  String _formatCurrency(num amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  /// Date formatter
  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy, HH:mm').format(date.toLocal());
  }

  /// Generate Commission Report PDF
  Future<Uint8List> generateCommissionReportPdf({
    required CommissionReportResponse report,
    required CommissionReportPeriod period,
    String? driverName,
  }) async {
    final pdf = pw.Document();

    // Define colors
    const primaryColor = PdfColor.fromInt(0xFF1976D2);
    const successColor = PdfColor.fromInt(0xFF4CAF50);
    const dangerColor = PdfColor.fromInt(0xFFF44336);
    const mutedColor = PdfColor.fromInt(0xFF757575);

    // Period label
    final periodLabel = switch (period) {
      CommissionReportPeriod.daily => 'Daily',
      CommissionReportPeriod.weekly => 'Weekly',
      CommissionReportPeriod.monthly => 'Monthly',
    };

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) =>
            _buildHeader(periodLabel: periodLabel, driverName: driverName),
        footer: (context) => _buildFooter(context),
        build: (context) => [
          // Summary Section
          _buildSummarySection(report, primaryColor, successColor, dangerColor),
          pw.SizedBox(height: 24),

          // Balance Overview
          _buildBalanceOverview(report, successColor, dangerColor),
          pw.SizedBox(height: 24),

          // Commission Details
          _buildCommissionDetails(report, primaryColor),
          pw.SizedBox(height: 24),

          // Transactions Table
          _buildTransactionsTable(
            report.transactions,
            successColor,
            dangerColor,
            mutedColor,
          ),
        ],
      ),
    );

    return pdf.save();
  }

  /// Build PDF header
  pw.Widget _buildHeader({required String periodLabel, String? driverName}) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 16),
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Commission Report',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                '$periodLabel Report${driverName != null ? ' - $driverName' : ''}',
                style: const pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.grey700,
                ),
              ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                'AkadeMove',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: const PdfColor.fromInt(0xFF1976D2),
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                'Generated: ${DateFormat('dd MMM yyyy, HH:mm').format(DateTime.now())}',
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build PDF footer
  pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(top: 16),
      decoration: const pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: PdfColors.grey300)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'This is a computer-generated document.',
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
          ),
          pw.Text(
            'Page ${context.pageNumber} of ${context.pagesCount}',
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
          ),
        ],
      ),
    );
  }

  /// Build summary section with current balance
  pw.Widget _buildSummarySection(
    CommissionReportResponse report,
    PdfColor primaryColor,
    PdfColor successColor,
    PdfColor dangerColor,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: const PdfColor.fromInt(0xFFF5F5F5),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Current Balance',
            style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            _formatCurrency(report.currentBalance),
            style: pw.TextStyle(
              fontSize: 28,
              fontWeight: pw.FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  /// Build balance overview (incoming/outgoing)
  pw.Widget _buildBalanceOverview(
    CommissionReportResponse report,
    PdfColor successColor,
    PdfColor dangerColor,
  ) {
    return pw.Row(
      children: [
        pw.Expanded(
          child: _buildBalanceCard(
            title: 'Incoming Balance',
            amount: report.incomingBalance,
            color: successColor,
            icon: '+',
          ),
        ),
        pw.SizedBox(width: 16),
        pw.Expanded(
          child: _buildBalanceCard(
            title: 'Outgoing Balance',
            amount: report.outgoingBalance,
            color: dangerColor,
            icon: '-',
          ),
        ),
      ],
    );
  }

  /// Build individual balance card
  pw.Widget _buildBalanceCard({
    required String title,
    required num amount,
    required PdfColor color,
    required String icon,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Container(
                width: 24,
                height: 24,
                decoration: pw.BoxDecoration(
                  color: color,
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                child: pw.Center(
                  child: pw.Text(
                    icon,
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
              pw.SizedBox(width: 8),
              pw.Text(
                title,
                style: const pw.TextStyle(
                  fontSize: 11,
                  color: PdfColors.grey700,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 12),
          pw.Text(
            _formatCurrency(amount),
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
    );
  }

  /// Build commission details section
  pw.Widget _buildCommissionDetails(
    CommissionReportResponse report,
    PdfColor primaryColor,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Commission Summary',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 16),
          pw.Table(
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(1),
            },
            children: [
              _buildTableRow(
                'Total Earnings',
                _formatCurrency(report.totalEarnings),
              ),
              _buildTableRow(
                'Total Commission',
                _formatCurrency(report.totalCommission),
              ),
              _buildTableRow('Net Income', _formatCurrency(report.netIncome)),
              _buildTableRow(
                'Commission Rate',
                '${report.commissionRate.toStringAsFixed(2)}%',
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build table row for commission details
  pw.TableRow _buildTableRow(String label, String value) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 6),
          child: pw.Text(
            label,
            style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey700),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 6),
          child: pw.Text(
            value,
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
            textAlign: pw.TextAlign.right,
          ),
        ),
      ],
    );
  }

  /// Build transactions table
  pw.Widget _buildTransactionsTable(
    List<CommissionTransaction> transactions,
    PdfColor successColor,
    PdfColor dangerColor,
    PdfColor mutedColor,
  ) {
    if (transactions.isEmpty) {
      return pw.Container(
        padding: const pw.EdgeInsets.all(24),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.grey300),
          borderRadius: pw.BorderRadius.circular(8),
        ),
        child: pw.Center(
          child: pw.Text(
            'No transactions in this period',
            style: pw.TextStyle(
              fontSize: 12,
              color: mutedColor,
              fontStyle: pw.FontStyle.italic,
            ),
          ),
        ),
      );
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Transaction History',
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 12),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          columnWidths: {
            0: const pw.FlexColumnWidth(2),
            1: const pw.FlexColumnWidth(1.5),
            2: const pw.FlexColumnWidth(2),
            3: const pw.FlexColumnWidth(1.5),
          },
          children: [
            // Header row
            pw.TableRow(
              decoration: const pw.BoxDecoration(
                color: PdfColor.fromInt(0xFFF5F5F5),
              ),
              children: [
                _buildTableHeader('Date'),
                _buildTableHeader('Type'),
                _buildTableHeader('Description'),
                _buildTableHeader('Amount'),
              ],
            ),
            // Data rows
            ...transactions.map((t) {
              final isEarning = t.type == CommissionTransactionTypeEnum.EARNING;
              final color = isEarning ? successColor : dangerColor;
              final prefix = isEarning ? '+' : '-';

              return pw.TableRow(
                children: [
                  _buildTableCell(_formatDate(t.createdAt)),
                  _buildTableCell(
                    isEarning ? 'Earning' : 'Commission',
                    color: color,
                  ),
                  _buildTableCell(t.description ?? t.orderType ?? '-'),
                  _buildTableCell(
                    '$prefix${_formatCurrency(t.amount)}',
                    color: color,
                    bold: true,
                  ),
                ],
              );
            }),
          ],
        ),
      ],
    );
  }

  /// Build table header cell
  pw.Widget _buildTableHeader(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
      ),
    );
  }

  /// Build table data cell
  pw.Widget _buildTableCell(String text, {PdfColor? color, bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 9,
          color: color,
          fontWeight: bold ? pw.FontWeight.bold : null,
        ),
      ),
    );
  }

  /// Share or print the PDF
  Future<void> sharePdf({
    required Uint8List pdfBytes,
    required String filename,
  }) async {
    await Printing.sharePdf(bytes: pdfBytes, filename: filename);
  }

  /// Print the PDF directly
  Future<void> printPdf({
    required Uint8List pdfBytes,
    required String filename,
  }) async {
    await Printing.layoutPdf(onLayout: (_) => pdfBytes, name: filename);
  }

  // ========== MERCHANT REPORTS ==========

  /// Generate Merchant Commission Report PDF
  Future<Uint8List> generateMerchantCommissionReportPdf({
    required num totalRevenue,
    required num totalCommission,
    required num netIncome,
    String? merchantName,
    String? period,
  }) async {
    final pdf = pw.Document();

    // Define colors
    const primaryColor = PdfColor.fromInt(0xFF1976D2);
    const successColor = PdfColor.fromInt(0xFF4CAF50);
    const dangerColor = PdfColor.fromInt(0xFFF44336);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) => _buildMerchantHeader(
          title: 'Commission Report',
          subtitle: period ?? 'Monthly Report',
          merchantName: merchantName,
        ),
        footer: (context) => _buildFooter(context),
        build: (context) => [
          // Summary Section
          _buildMerchantSummarySection(
            totalRevenue: totalRevenue,
            totalCommission: totalCommission,
            primaryColor: primaryColor,
          ),
          pw.SizedBox(height: 24),

          // Balance Overview
          _buildMerchantBalanceOverview(
            totalRevenue: totalRevenue,
            totalCommission: totalCommission,
            successColor: successColor,
            dangerColor: dangerColor,
          ),
          pw.SizedBox(height: 24),

          // Commission Details
          _buildMerchantCommissionDetails(
            totalRevenue: totalRevenue,
            totalCommission: totalCommission,
            netIncome: netIncome,
            primaryColor: primaryColor,
          ),
          pw.SizedBox(height: 24),

          // Commission Chart Legend
          _buildMerchantCommissionChart(
            netIncome: netIncome,
            totalCommission: totalCommission,
          ),
        ],
      ),
    );

    return pdf.save();
  }

  /// Generate Merchant Sales Report PDF
  Future<Uint8List> generateMerchantSalesReportPdf({
    required num totalOrders,
    required num completedOrders,
    required num cancelledOrders,
    required num totalRevenue,
    required num averageOrderValue,
    required List<MerchantAnalytics200ResponseDataTopSellingItemsInner>
    topSellingItems,
    String? merchantName,
    String? period,
  }) async {
    final pdf = pw.Document();

    // Define colors
    const primaryColor = PdfColor.fromInt(0xFF1976D2);
    const successColor = PdfColor.fromInt(0xFF4CAF50);
    const warningColor = PdfColor.fromInt(0xFFFF9800);

    // Calculate completion rate
    final completionRate = totalOrders > 0
        ? (completedOrders / totalOrders) * 100
        : 0.0;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) => _buildMerchantHeader(
          title: 'Sales Report',
          subtitle: period ?? 'Monthly Report',
          merchantName: merchantName,
        ),
        footer: (context) => _buildFooter(context),
        build: (context) => [
          // Sales Summary
          _buildSalesSummarySection(
            totalOrders: totalOrders,
            completedOrders: completedOrders,
            cancelledOrders: cancelledOrders,
            totalRevenue: totalRevenue,
            averageOrderValue: averageOrderValue,
            completionRate: completionRate,
            primaryColor: primaryColor,
            successColor: successColor,
            warningColor: warningColor,
          ),
          pw.SizedBox(height: 24),

          // Top Selling Products
          _buildTopSellingProductsTable(
            topSellingItems: topSellingItems,
            primaryColor: primaryColor,
          ),
        ],
      ),
    );

    return pdf.save();
  }

  /// Build merchant PDF header
  pw.Widget _buildMerchantHeader({
    required String title,
    required String subtitle,
    String? merchantName,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 16),
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                '$subtitle${merchantName != null ? ' - $merchantName' : ''}',
                style: const pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.grey700,
                ),
              ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                'AkadeMove',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: const PdfColor.fromInt(0xFF1976D2),
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                'Generated: ${DateFormat('dd MMM yyyy, HH:mm').format(DateTime.now())}',
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build merchant summary section
  pw.Widget _buildMerchantSummarySection({
    required num totalRevenue,
    required num totalCommission,
    required PdfColor primaryColor,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: const PdfColor.fromInt(0xFFF5F5F5),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Total Revenue',
            style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            _formatCurrency(totalRevenue),
            style: pw.TextStyle(
              fontSize: 28,
              fontWeight: pw.FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  /// Build merchant balance overview
  pw.Widget _buildMerchantBalanceOverview({
    required num totalRevenue,
    required num totalCommission,
    required PdfColor successColor,
    required PdfColor dangerColor,
  }) {
    return pw.Row(
      children: [
        pw.Expanded(
          child: _buildBalanceCard(
            title: 'Gross Sales',
            amount: totalRevenue,
            color: successColor,
            icon: '+',
          ),
        ),
        pw.SizedBox(width: 16),
        pw.Expanded(
          child: _buildBalanceCard(
            title: 'Platform Commission',
            amount: totalCommission,
            color: dangerColor,
            icon: '-',
          ),
        ),
      ],
    );
  }

  /// Build merchant commission details
  pw.Widget _buildMerchantCommissionDetails({
    required num totalRevenue,
    required num totalCommission,
    required num netIncome,
    required PdfColor primaryColor,
  }) {
    final commissionRate = totalRevenue > 0
        ? (totalCommission / totalRevenue) * 100
        : 0;

    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Commission Summary',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 16),
          pw.Table(
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(1),
            },
            children: [
              _buildTableRow('Gross Sales', _formatCurrency(totalRevenue)),
              _buildTableRow(
                'Platform Commission',
                _formatCurrency(totalCommission),
              ),
              _buildTableRow('Net Income', _formatCurrency(netIncome)),
              _buildTableRow(
                'Commission Rate',
                '${commissionRate.toStringAsFixed(2)}%',
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build merchant commission chart legend
  pw.Widget _buildMerchantCommissionChart({
    required num netIncome,
    required num totalCommission,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Income Breakdown',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 16),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            children: [
              _buildLegendItem(
                'Net Income',
                _formatCurrency(netIncome),
                const PdfColor.fromInt(0xFF5EC4D4),
              ),
              _buildLegendItem(
                'Commission',
                _formatCurrency(totalCommission),
                const PdfColor.fromInt(0xFFF9EFC7),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build legend item for charts
  pw.Widget _buildLegendItem(String label, String value, PdfColor color) {
    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        pw.Container(
          width: 16,
          height: 16,
          decoration: pw.BoxDecoration(
            color: color,
            borderRadius: pw.BorderRadius.circular(4),
          ),
        ),
        pw.SizedBox(width: 8),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              label,
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
            ),
            pw.Text(
              value,
              style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  /// Build sales summary section
  pw.Widget _buildSalesSummarySection({
    required num totalOrders,
    required num completedOrders,
    required num cancelledOrders,
    required num totalRevenue,
    required num averageOrderValue,
    required double completionRate,
    required PdfColor primaryColor,
    required PdfColor successColor,
    required PdfColor warningColor,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Sales Overview',
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 16),
        pw.Row(
          children: [
            pw.Expanded(
              child: _buildStatCard(
                title: 'Total Orders',
                value: totalOrders.toString(),
                color: primaryColor,
              ),
            ),
            pw.SizedBox(width: 12),
            pw.Expanded(
              child: _buildStatCard(
                title: 'Completed',
                value: completedOrders.toString(),
                color: successColor,
              ),
            ),
            pw.SizedBox(width: 12),
            pw.Expanded(
              child: _buildStatCard(
                title: 'Cancelled',
                value: cancelledOrders.toString(),
                color: warningColor,
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 16),
        pw.Row(
          children: [
            pw.Expanded(
              child: _buildStatCard(
                title: 'Total Revenue',
                value: _formatCurrency(totalRevenue),
                color: primaryColor,
              ),
            ),
            pw.SizedBox(width: 12),
            pw.Expanded(
              child: _buildStatCard(
                title: 'Avg. Order Value',
                value: _formatCurrency(averageOrderValue),
                color: primaryColor,
              ),
            ),
            pw.SizedBox(width: 12),
            pw.Expanded(
              child: _buildStatCard(
                title: 'Completion Rate',
                value: '${completionRate.toStringAsFixed(1)}%',
                color: successColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build stat card for sales summary
  pw.Widget _buildStatCard({
    required String title,
    required String value,
    required PdfColor color,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  /// Build top selling products table
  pw.Widget _buildTopSellingProductsTable({
    required List<MerchantAnalytics200ResponseDataTopSellingItemsInner>
    topSellingItems,
    required PdfColor primaryColor,
  }) {
    if (topSellingItems.isEmpty) {
      return pw.Container(
        padding: const pw.EdgeInsets.all(24),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.grey300),
          borderRadius: pw.BorderRadius.circular(8),
        ),
        child: pw.Center(
          child: pw.Text(
            'No sales data available',
            style: pw.TextStyle(
              fontSize: 12,
              color: PdfColors.grey600,
              fontStyle: pw.FontStyle.italic,
            ),
          ),
        ),
      );
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Top Selling Products',
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 12),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          columnWidths: {
            0: const pw.FlexColumnWidth(1),
            1: const pw.FlexColumnWidth(3),
            2: const pw.FlexColumnWidth(1.5),
            3: const pw.FlexColumnWidth(2),
          },
          children: [
            // Header row
            pw.TableRow(
              decoration: const pw.BoxDecoration(
                color: PdfColor.fromInt(0xFFF5F5F5),
              ),
              children: [
                _buildTableHeader('#'),
                _buildTableHeader('Product Name'),
                _buildTableHeader('Orders'),
                _buildTableHeader('Revenue'),
              ],
            ),
            // Data rows
            ...topSellingItems.take(10).toList().asMap().entries.map((entry) {
              final index = entry.key + 1;
              final item = entry.value;

              return pw.TableRow(
                children: [
                  _buildTableCell('$index'),
                  _buildTableCell(item.menuName),
                  _buildTableCell('${item.totalOrders}'),
                  _buildTableCell(
                    _formatCurrency(item.totalRevenue),
                    color: primaryColor,
                    bold: true,
                  ),
                ],
              );
            }),
          ],
        ),
      ],
    );
  }
}
