import 'package:flutter/material.dart';

class MerchantAvailabilityToggle extends StatelessWidget {
  final bool isOnline;
  final bool isTakingOrders;
  final String operatingStatus;
  final Function(bool) onOnlineChanged;
  final Function(bool) onOrderTakingChanged;
  final Function(String) onOperatingStatusChanged;
  final bool isLoading;

  const MerchantAvailabilityToggle({
    super.key,
    required this.isOnline,
    required this.isTakingOrders,
    required this.operatingStatus,
    required this.onOnlineChanged,
    required this.onOrderTakingChanged,
    required this.onOperatingStatusChanged,
    this.isLoading = false,
  });

  Color get statusColor {
    if (!isOnline) return Colors.red;
    if (!isTakingOrders) return Colors.orange;
    if (operatingStatus == 'OPEN') return Colors.green;
    return Colors.amber;
  }

  String get statusText {
    if (!isOnline) return 'Offline';
    if (!isTakingOrders) return 'Online (Paused)';
    return 'Online - $operatingStatus';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Status Summary Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: statusColor.withValues(alpha: 0.2),
                    child: Icon(
                      isOnline
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: statusColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          statusText,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          isOnline
                              ? 'You can receive orders'
                              : 'Not receiving orders',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Online Toggle
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isOnline ? 'Online' : 'Offline',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isOnline ? 'Available for orders' : 'Not available',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  Switch(
                    value: isOnline,
                    onChanged: isLoading ? null : onOnlineChanged,
                    activeThumbColor: Colors.green,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Order Taking Toggle (only show when online)
          if (isOnline) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isTakingOrders ? 'Taking Orders' : 'Paused',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isTakingOrders
                              ? 'Ready to accept orders'
                              : 'Temporarily paused',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    Switch(
                      value: isTakingOrders,
                      onChanged: isLoading ? null : onOrderTakingChanged,
                      activeThumbColor: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Operating Status Dropdown (only show when online)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Store Status',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 12),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: operatingStatus,
                      onChanged: isLoading
                          ? null
                          : (String? newValue) {
                              if (newValue != null) {
                                onOperatingStatusChanged(newValue);
                              }
                            },
                      items: const [
                        DropdownMenuItem(
                          value: 'OPEN',
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.green,
                              ),
                              SizedBox(width: 8),
                              Text('Open'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'BREAK',
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.orange,
                              ),
                              SizedBox(width: 8),
                              Text('On Break'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'MAINTENANCE',
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.amber,
                              ),
                              SizedBox(width: 8),
                              Text('Maintenance'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'CLOSED',
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.red,
                              ),
                              SizedBox(width: 8),
                              Text('Closed'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Let customers know your store status',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
