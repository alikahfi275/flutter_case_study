lib/

├── core/

│   ├── routes/

│   │   └── bottom_nav.dart        # Konfigurasi navigasi bawah

│   └── utils/

│       ├── animated.dart          # Helper animasi & transisi

│       └── formatters.dart        # Utility formatting data (tanggal, angka, dsb.)

├── data/

│   ├── models/

│   │   ├── form_money_tracker_model.dart

│   │   ├── form_product_model.dart

│   │   ├── money_tracker_model.dart

│   │   └── product_model.dart

│   ├── providers/

│   │   ├── bottom_nav_provider.dart

│   │   ├── form_provider.dart

│   │   ├── moeny_tracker_provider.dart

│   │   ├── product_form_provider.dart

│   │   └── products_provider.dart

│   └── repositories/

│       └── products_repository.dart

├── services/

│   └── api_service.dart           # Layanan API & network

├── view/

│   ├── money_tracker_screen.dart

│   ├── product_detail_screen.dart

│   └── products_screen.dart

├── widgets/

│   ├── button_delete.dart

│   ├── money_tracker_card.dart

│   ├── money_tracker_dialog.dart

│   ├── money_trackers_list.dart

│   ├── product_card.dart

│   ├── product_dialog.dart

│   └── products_list.dart

└── main.dart                       # Entry point aplikasi


⚙️ Fitur Utama

✅ Manajemen Pengeluaran & Produk

Tambah, hapus, dan lihat detail pengeluaran & produk.

🔄 Reactive State Management

Menggunakan Riverpod untuk manajemen state yang aman dan efisien.

🌐 Integrasi API

api_service.dart menangani komunikasi ke backend melalui repository layer.

🧩 Komponen Modular

Setiap fitur dipisahkan dalam folder (Model, Provider, Repository, View, Widget).

🎨 UI Dinamis

Menggunakan widget reusable seperti product_card, money_tracker_card, dan button_delete.

🧩 Dependensi Utama
Package Deskripsi
flutter_riverpod State management
dio Komunikasi API
intl Format angka & tanggal
flutter/material.dart UI Framework bawaan Flutter

🧩 Function/Class

- class BottomNav extends ConsumerWidget
    Komponen utama untuk navigasi bawah (Bottom Navigation Bar) aplikasi.
    Menggunakan Riverpod untuk memantau dan mengubah halaman aktif berdasarkan bottomNavProvider.

- class AnimatedSlideFade extends StatefulWidget
    Widget reusable untuk menambahkan animasi transisi halus ke elemen UI (misal card, list, tombol, dsb.)

- String formatRupiah(double number)
    Mengubah angka menjadi format mata uang Rupiah tanpa desimal.

- String formatRupiahWithDecimal(double number)
    Sama seperti formatRupiah, tapi menampilkan dua angka desimal (misal untuk harga atau pajak).

- FormMoneyTrackerModel
    Menampung data sementara saat pengguna mengisi form transaksi.

    * copyWith() — membuat salinan objek dengan nilai baru, berguna saat mengupdate form secara parsial di provider.

- FormProductModel
    Menampung data input pengguna saat membuat atau mengedit produk.

- MoneyTracker
    Model untuk data transaksi uang yang sudah tersimpan.

- Product
    Menampung informasi produk dan detail tambahan (opsional).

    * factory Product.fromJson(Map<String, dynamic> json) → mengubah data JSON dari API menjadi objek Product

    * toJson() → mengubah objek Product kembali menjadi Map agar bisa dikirim ke API.

- Bottom Navigation Notifier
    BottomNavNotifier mengatur index halaman yang sedang aktif pada bottom navigation.

    * state adalah integer, default 0 (halaman pertama).

    * pages adalah daftar halaman (MoneyTrackerScreen dan ProductsScreen).

    * changePage(int index) → digunakan untuk ganti halaman.

    * bottomNavProvider adalah provider global, bisa diakses di widget untuk membaca index dan mengganti halaman.

- Transaction Form Notifier
    Mengelola form input transaksi (judul, jumlah, jenis: income/expense).

    * setTitle, setAmount, setIsIncome → update state form secara immutable via copyWith.

    * reset() → reset form ke default.

    * autoDispose → otomatis dibuang ketika widget yang menggunakan provider hilang, menghemat memori.

- Money Tracker Notifier
    Mengelola list transaksi keuangan.

    * addTransaction → buat objek MoneyTracker baru dengan UUID, lalu masukkan ke state.

    * deleteTransaction → hapus transaksi berdasarkan id.

    * moneyTrackerProvider → global provider untuk list transaksi, bisa di-watch di UI untuk rebuild otomatis.

- Product Form Notifier
    Products List Provider & Detail Provider

    * build() → otomatis dipanggil saat provider di-watch pertama kali, return list produk.

    * refreshProducts() → reload list produk.

    * addProduct() / deleteProduct() → update list produk dan refresh.

    * productDetailProvider → FutureProvider.family untuk fetch detail produk berdasarkan id, auto-dispose ketika tidak dipakai.

- Provider untuk Repository
    productsRepositoryProvider adalah provider global untuk ProductsRepository

- Konstruktor Repository
    ProductsRepository menyimpan instance _api yang digunakan untuk melakukan HTTP request.

- Method getProducts
    Memanggil endpoint /objects untuk mengambil daftar produk.

- Method getProduct
    Mengambil detail satu produk berdasarkan id.

- Method addProduct
    Menambahkan produk baru lewat endpoint POST /objects.

- Method deleteProduct
    Menghapus produk berdasarkan id.

- Provider untuk ApiService
    apiServiceProvider adalah global provider untuk instance ApiService.

- Konstruktor ApiService
    _dio adalah instance Dio yang digunakan untuk melakukan HTTP request.

    * baseUrl → URL dasar API.

    * connectTimeout → timeout saat mencoba connect ke server (10 detik).

    * receiveTimeout → timeout saat menunggu response (10 detik).

- Interceptor
    * onRequest → dijalankan sebelum request dikirim:

    Menampilkan method dan URL request di console.

    Berguna untuk debugging request.

    * onResponse → dijalankan saat response diterima:

    Mengubah response JSON menjadi format pretty print supaya mudah dibaca.

    Menampilkan statusCode dan data response.

    * onError → dijalankan saat terjadi error:

    Jika ada response dari server → tampilkan statusCode dan data error.

    Jika tidak ada response (misal network error) → tampilkan message error.

- Method HTTP
    Method ini membungkus Dio agar lebih sederhana dipanggil oleh repository.

- MoneyTrackerScreen
    * transactions → daftar transaksi.

    * transactionsNotifier → untuk memanggil method addTransaction / deleteTransaction.

    * Hitung total -> Menghitung jumlah income dan expense dari list transaksi.

    * FloatingActionButton
    Memunculkan dialog input transaksi baru.

- ProductDetailScreen
    Menggunakan FutureProvider.family untuk fetch detail produk berdasarkan id

    * when → memudahkan menampilkan loading / error / data secara terpisah.

    * Jika product.data ada → looping entries untuk menampilkan key & value.

    * Tombol delete (ButtonDelete) berada di AppBar.

- ProductsScreen
    Menampilkan daftar produk dan bisa menambah produk baru.

    * AsyncNotifierProvider untuk list produk.

    * Menampilkan daftar produk (ProductsList).

    * Swipe down → refresh list produk.

    * AnimatedSlideFade → efek slide + fade saat tombol muncul.

- MoneyTrackerNotifier
    Membuat transaksi baru dengan id unik.

- ButtonDelete
    Widget tombol delete untuk produk, dengan konfirmasi dialog sebelum hapus.

- MoneyTrackerCard
    Widget kartu untuk menampilkan transaksi (judul, tipe, jumlah) dan tombol delete.

    * transaction → object MoneyTracker.

    * onDelete → callback ketika tombol delete ditekan.
    
- MoneyTrackerDialog
    Dialog untuk input transaksi baru.

    * onSubmit → callback saat user submit form.

    * _formKey → key untuk validasi form.

- MoneyTrackerList
    List animasi untuk menampilkan daftar transaksi atau item generik.

    * items → daftar item

    * itemBuilder → builder untuk tiap item

    * duration → durasi animasi insert/remove

- ProductCard
    Menampilkan informasi produk: nama + data, bisa tap untuk detail.

    * product → object produk

    * data → map data detail produk

- ProductDialog
    Dialog untuk menambahkan produk baru.

    * Cancel → reset form & tutup

    * Add → validasi form → convert ke Product → panggil productsListProvider.notifier.addProduct → tampilkan SnackBar → reset form

- ProductsList
    Menampilkan daftar produk dengan ListView.builder.

  - products → list produk
