_USER :_

1. ganti cover di carousel user
2. set destination di ride -> tap location -> driver nearby. tapi mapnya baru bisa keroutes ke driver neraby setelah ditap lebih dari 5x✅
3. cek ui saat klik delivery menu di user (error null check operator used on a null value)
4. ui my voucher di user (blm dicreate)✅
5. linking my voucher user with api
6. popular merchant card di dashboard user blm responsif (overflowed)✅
7. view all button untuk popular merchant blm keroutes (otw)
8. menu AMart user error sesuai ss
9. bottom overflowed di detail profile user
10. right overflowed ui di text field phone number user
11. double form achievement (harusnya 1 aja)
12. dialog achievement detail (jelasin gold badge itu apa, dst)
13. search pick up dan drop off location blm indo translate
14. notification page user✅
15. unexpected routing behavior saat abis change pass+edit profile user

_GENERAL:_

1. ui privacy policies, masih ketimbun stick buttonnya
2. privacy policy blm indo translate
3. succes sign up toast blm ada
4. forgot password (failed to render email template)

_MERCHANT:_

1. notification page merchant✅
2. unexpected routing behavior saat abis set up outlet
3. close/open merchant button + dialog yes/no (blm dicreate) ✅
4. export pdf sales report, commission report
5. withdrawal merchant
6. create item category merchant
7. increase decrease item stock blm centered
8. create item blm auto reload
9. harusnya pas success sign up dan sign in as new merchant, diarahkan ke profile dulu untuk set up outlet. jika sudah set up, maka baru bisa create menu dan melakukan transaksi
10. set up outlet di merchant kan ada field untuk create item. nah pas udah success, itemnya ga keupdate di menu item
11. change password dan edit profile merchant blm berhasil/blm dihubungkan ya?

_DRIVER:_

1. notification page driver✅
2. online/offline driver button + dialog yes/no (blm dicreate) ✅
3. withdrawal driver
4. gagal sign up as new driver (service failed to fulfill an apperantly valid request)
5. cek driver semuanya

//GENERAL DASHBOARD:

- subscribe akademove with email
- dashboard tiap product buttonnya hanya untuk routes ke sign up saja
- removed our campus partner
- dynamic system status
- add NIM, KTM in privacy policy

//USER WEB:

- verify email failed
- implemented booking menu di user
- linking top up wallet user
- remove badge menu, karena sudah menyatu dengan profile
- removed settig karena gapenting
- failed fprgot password

//DRIVER WEB:

- wrong roles in driver
- error profile driver (useMyDriver must be used within a MyDriverProvider)
- sign up as new driver

//MERCHANT WEB

- phone number tdk ke copy saat checklist "use my personal info"
- removed merchant email
- tambahkan item's category
- edit, mark out of stock, dan delete item succes, tapi ga auto reload
- fixed location di profile (tanpa edit)

//ADMIN WEB:

- change role. restored access failed
- delete cureent password on change password (jadi hanya ada new pass dan confirm pass)
- invite someone failed
- broken search functionality in driver menu (search by name aja)
- rename partner to merchant
- quiz dan approval docs driver
- admin analytics broken query
  = commission rates failed config from db
- audit logs ailed config from db
- failed edit commission rate

//OPERATOR:

- remove change role in user
- restored access failed
- tambah menu approval (untuk docs,quiz, update docs)
- broken search functionality in driver menu (search by name aja)
- coupon error
- view response contact us failed to laod contacy

NOTES:
· minta email, telp

- minta data diri anggota full
- sync dummy db all role

