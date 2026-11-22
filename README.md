# myportofolio_mobile

Portofolio versi mobile

## Tugas 7
1. Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!

> _Widget tree_ merupakan struktur hirarki yang menyusun _widget_. Hubungan parent-child di sini menggambarkan hirarki bagaimana suatu _widget_ membungkus _widget_ yang lain di mana dalam hal ini _parent_ membungkus _child_.

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!

- Scaffold: pembungkus & kerangka satu halaman
- AppBar: komponen teratas layar aplikasi
- Row: properti yang menyusun _child_ secara horizontal
- Column: properti yang menyusun _child_ secara vertikal
- Text: display teks
- Icon: display icon spesifik untuk tombol
- Container: pembungkus suatu bagian tertentu pada halaman 
- Padding: menambahkan padding
- SizedBox: boks dengan ukuran spesifik --> dalam hal ini untuk membuat _space_ di tengah _widget_
- GridView: display konten dalam format grid
- Material: pembungkus yang dapat memberi warna dan efek
- InkWell: memberi animasi _ripple_ ketika di-tap
- SnackBar: display yang muncul sebagai _pop-up message_ ketika menekan tombol
- MyHomePage: membungkus dan mengatur layout keseluruhan homepage 
- InfoCard: Container yang membungkus informasi seperti kelas dan npm
- ItemCard: Material yang membungkus informasi untuk tombol _view_ dan _add_.
- ProfileHeader: Container yang membungkus informasi nama dan _greeting_ sebagai header utama
- LogoutButton: SizedBox untuk tombol logout

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!

> MaterialApp adalah pembungkus tingkat aplikasi yang berfungsi sebagai _core component_ Flutter dan dapat digunakan untuk membuat suatu aplikasi menjadi menarik (mengikuti _guideline_ Material Design). Umumnya digunakan sebagai _root widget_ karena kita dapat mengakses berbagai _widget_ yang disediakan Flutter seperti Text, Scaffold, AppBar, dll. 

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?

> _Stateless_ bersifat _immutable_ (tidak dapat diubah) sedangkan _stateful_ bersifat _mutable_. _Stateless_ digunakan ketika kita ingin me-_replace_ dengan yang baru ketika ada perubahan pada _widget_. Sementara itu, _stateful_ digunakan ketika elemen yang dirender berubah berdasarkan _event_ seperti interaksi _user_, operasi _network_, dll.

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?

> BuildContext menunjukkan lokasi _widget_ dalam _widget tree_, ini penting supaya antar-_widget_ dapat berinteraksi. BuildContext ini diletakkan sebagai argumen metode build() [**build(BuildContext context)**]. Context di sini dibuat oleh flutter untuk setiap _widget_. Fungsi .of akan memakai context sebagai titik awal penelusuran _tree_ (misal untuk Theme.of --> penelusuran hingga menemukan _widget_ bertipe Theme).

6. Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?

> Hot reload memungkinkan _developer_ melihat perubahan kode tanpa memulai ulang aplikasi. Flutter akan otomatis melakukan _compile_ setiap perubahan kode dan mengirimnya ke Dart Virtual Machine yang sedang berjalan. VM kemudian memperbarui struktur _widget tree_. Di sisi lain, pada hot restart, flutter akan menghapus _state_ aplikasi yang ada dan memulai aplikasi dari awal. Semua variabel akan diinisialisai ulang dan aplikasi kembali ke _state_ awalnya. Hot reload cenderung lebih cepat dari hot restart. Adapun hot reload lebih efektif untuk perubahan UI dan logika yang tidak memengaruhi _state_ global, sementara hot restart untuk perubahan yang memengaruhi _state_ global atau struktur aplikasi.

### AI Disclosure

AI yang saya gunakan adalah Claude Sonnet 5. Berikut alur prompting yang saya terapkan:

1. Menganalisis struktur kode yang sudah dibuat secara mandiri
2. Bertanya mengenai logika dan struktur kode
3. Menganalisis jawaban dan rangkaian kode yang dicontohkan untuk kemudian diimplementasi dan dimodifikasi secara mandiri

Selanjutnya, berikut adalah spesifikasi bantuan dari AI yang saya gunakan:

1. Pembuatan desain untuk tampilan aplikasi
2. Analisis dan _refactor_ kode yang sudah dibuat menjadi sesuai dengan desain yang diinginkan
3. Analisis fungsi, struktur, dan penerapan elemen-elemen flutter

`Log AI: https://claude.ai/share/c902729a-ea99-4fa9-ac4c-84bb1670b6c2`

## Tugas 8
1. Jelaskan perbedaan antara Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop(). Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.

- Navigator.push() --> menambahkan suatu _route_ ke dalam stack _route_ yang dikelola oleh Navigator sehingga berada pada paling atas stack dan ditampilkan kepada pengguna.
- Navigator.pop() --> menghapus _route_ yang sedang ditampilkan kepada pengguna (yang berada pada paling atas stack) dari stack _route_ yang dikelola oleh Navigator. Dengan method ini, aplikasi berpindah dari _route_ yang sedang ditampilkan kepada pengguna ke _route_ yang berada di bawahnya pada stack.
- Navigator.pushReplacement() --> menghapus _route_ yang sedang ditampilkan kepada pengguna dan menggantinya dengan suatu _route_ (_replace_). Method ini menyebabkan aplikasi untuk berpindah dari _route_ yang sedang ditampilkan kepada pengguna ke suatu _route_ yang diberikan. Pada stack _route_ yang dikelola Navigator, _route_ lama pada atas stack akan digantikan secara langsung oleh _route_ baru yang diberikan tanpa mengubah kondisi elemen stack yang berada di bawahnya.

> Adapun metode yang digunakan untuk membuka formulir dari kartu aksi adalah Navigator.push().
Opsi Home di drawer membawa pengguna kembali ke halaman utama dengan memanfaatkan Navigator.pushReplacement() di dalam onTap(). pushReplacement ini akan mengganti _route_ sekarang dengan _route_ ke MyHomePage() sehingga akan kembali ke halaman utama.

2. Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.

> Drawer pada dasarnya memang dibuat satu kali dan dipanggil di berbagai halaman seperti Project Form dan Experience Form (di dalam Scaffold) sehingga apabila ada perubahan, akan tetap konsisten di setiap halaman. Adapun Scaffold adalah suatu kerangka yang dibuat setiap halaman untuk mengatur tata letak AppBar, body, dan drawer. Penempatannya akan sama karena Project Form Page dan Experience Form Page memiliki struktur Scaffold yang serupa. Untuk _style_ dari AppBar dan Drawer diwariskan lewat AppTheme (di theme.dart) melalui MaterialApp (di main.dart). Di **theme.dart** terdapat kode berikut di class AppTheme dalam ThemeData():

```
scaffoldBackgroundColor: AppColors.cream,
drawerTheme: const DrawerThemeData(
    backgroundColor: AppColors.cream,
),
```
Ini menyebabkan semua halaman portofolio memiliki _background_ halaman & drawer berwarna cream.

3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.

> Tata letak tersebut dipilih supaya struktur formulir konsisten untuk Experience Form dan Page Form, yang berubah hanya nama dan tipe field untuk input data formulir. Widget pengatur jarak (Padding) dapat memberikan jarak yang sesuai untuk setiap field input sehingga tidak terlalu rapat. Adapun widget penggulir ketika ruang layar terbatas (SingleChildScrollView) adalah untuk mengantisipasi layar kecil tetapi konten yang ditampilkan banyak, sehingga mendukung opsi menggulir layar supaya konten tidak dipaksakan untuk tampil seluruhnya hingga memenuhi layar.

4. Apa peran GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.

> GlobalKey<FormState> adalah referensi ke FormState milik Form sehingga method seperti validate() dan reset() bisa dipanggil dari luar form, dalam hal ini adalah saat tombol simpan ditekan. Saat tombol ini ditekan, validate() akan memanggil validator masing-masing field yang terdaftar dan mengembalikan true hanya jika semua validator mengembalikan null. Contoh nilai yang ditolak adalah saat nama _experience_ kosong (validator mengembalikan "Experience's name must not be empty!"). 

> Memilih jenis input atau atau _keyboard_ saja belum cukup karena _keyboard_ tidak bisa mengecek aturan-aturan seperti apakah field kosong atau formatnya benar. Input juga bisa masuk lewat jalur lain, misalnya jika pengguna melakukan _copy paste_ teks apa saja walaupun dengan keyboardType: TextInputType.number. 

### AI Disclosure

AI yang saya gunakan adalah Claude Sonnet 5. Berikut alur prompting yang saya terapkan:

1. Menganalisis struktur kode yang sudah dibuat secara mandiri
2. Bertanya mengenai kebenaran logika dan struktur kode
3. Menganalisis jawaban dan rangkaian kode yang dicontohkan untuk kemudian diimplementasi dan dimodifikasi secara mandiri

Selanjutnya, berikut adalah spesifikasi bantuan dari AI yang saya gunakan:

1. Analisis dan _refactor_ kode yang sudah dibuat menjadi sesuai dengan desain yang diinginkan
2. Analisis fungsi, struktur, dan penerapan elemen-elemen flutter
3. Membantu menganalisis pertanyaan dan logika kebenaran jawaban yang diajukan di README.

`Log AI: https://claude.ai/share/9f3d8bb2-f27e-4719-886c-1f025b299134`