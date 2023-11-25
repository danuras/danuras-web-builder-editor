<h2>Cara Deploy Manual</h2>
<ol>
    <li>Download atau clone repositori berikut: (<a href="https://github.com/danuras/danuras-web-builder.git">https://github.com/danuras/danuras-web-builder.git</a>)</li>
    <li>Run <code style="white-space: pre;">composer install</code> di folder projek yang sudah diclone</li>
    <li>duplikat file <code style="white-space: pre;">.env.example-2</code> lalu rename hasil duplikatnya dengan <code style="white-space: pre;">.env</code></li>
    <li>konfigurasi email pada file <code style="white-space: pre;">.env</code></li>
    <h3>Pengaturan Email</h3>
        <pre>
MAIL_USERNAME=&lt;email pengirim&gt;
MAIL_PASSWORD=&lt;password aplikasi email pengirim&gt;
MAIL_FROM_ADDRESS=&lt;email pengirim&gt;
MAIL_FROM_NAME=&lt;nama email pengirim&gt;</pre>
    </li>
    <li>Buat database bernama <code>dbwebbuilder</code> pada xampp</li>
    <li>Run <code style="white-space: pre;">php artisan migrate</code></li>
    <li>Run <code style="white-space: pre;">php artisan db:seed --class=DatabaseSeeder</code> untuk mengisi data di database dengan data dami</li>
    <li>Run <code style="white-space: pre;">php artisan key:generate</code> untuk membuat App Key</li>
    <li>Upload seluruh file projek di layanan hosting dan sesuaikan.</li>
    <li>Buat database dengan isian dari mengimport file berikut: <a href="https://github.com/danuras/danuras-web-builder.git">https://github.com/danuras/danuras-web-builder.git</a> </li>
    <li>Sesuaikan konfigurasi database pada file <code style="white-space: pre;">.env</code></li>
    <pre>
DB_DATABASE=&lt;nama database yang berada di hosting&gt;
DB_USERNAME=&lt;username database yang berada di hosting&gt;
DB_PASSWORD=&lt;password database yang berada di hosting&gt;</pre>
    <li>buka aplikasi <code style="white-space: pre;">danuras-web-builder-editor</code></li>
    <li>masukan link web atau endpoint web yang telah di deploy.</li>
    <li>login dengan email: <code style="white-space: pre;">a@a</code>, password: <code style="white-space: pre;">password</code></li>
    <li>Masuk ke menu pengguna</li>
    <li>Tambahkan email anda beserta passwordnya</li>
    <li>Ubah email yang ditambahkan tersebut sebagai akun utama</li>
    <li>logout dari aplikasi di menu pengaturan.</li>
    <li>Login dengan akun yang telah ditambahkan sebelumnya.</li>
    <li>Masuk ke menu pengguna.</li>
    <li>Hapus akun default dengan email <code style="white-space: pre;">a@a</code>, password: <code style="white-space: pre;">a@a</code>.</li>
    <li>Selesai, kirim email ke <code style="white-space: pre;">salam123.sb27@gmail.com</code> bila butuh bantuan.</li>
</ol>
<h2>Link (DEMO): https://demo-indoramah-web.000webhostapp.com/</h2>