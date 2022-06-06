### 1.Ekran Kayıtlı Kullanıcı ekranı:
Her kullanıcının kendine ait favorileri ve sepetteki ürünlerini  firebase’de tutulup, real time olarak çekiliyor. Sepetekki ürünler  ve favori ürünler dinamik olarak gösteriliyor ve hesaplanıyor.  Ayrıca realtime olarak değişikleri  gösteriyor.


### 2.Ekran Admin ekranı:
Admin ise kategorileri görüyor ve yeni bir kategori ekleyebiliyor.  Diğer yandan istediği kategoriye ürün ekleyebiliyor. Seçilen kategori one-to-one olarak ayarladım. Uygulamadaki tüm resimleri ise Firebase Storage’da tutuyorum.

### 3.Kullanıcı Register/Loging/Forgotpassword
Kullanıcı isterse üye olabilir ve o şekilde appe' girebilir. Şimdilik Anonymous şekilde girişi aktif etmedim. Eğerki kullanıcı register olduktan sonra şifresini unuttu ise, vermiş olduğu e-mail'e reset password adlı link firebase tarafından iletiliyor ve kullanıcı değiştirdiği şifresiyle girişyapabiliyor.

<img width="876" alt="Ekran Resmi 2022-06-06 16 22 45" src="https://user-images.githubusercontent.com/13710309/172169143-11758b14-1d16-4149-8b75-c524c1e9e3b8.png">
<img width="876" alt="Ekran Resmi 2022-06-06 16 23 09" src="https://user-images.githubusercontent.com/13710309/172169159-07e0ef8d-9a50-4d12-af10-159e7317dcd6.png">

