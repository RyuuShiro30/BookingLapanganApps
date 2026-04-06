import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true;

  // --- Konstanta Warna ---
  final Color backgroundColor = const Color(0xFFF3F4F7);
  final Color navyDark = const Color(0xFF1B2430);
  final Color primaryBlue = const Color(0xFF135B9D);
  final Color accentGreen = const Color(0xFF38B285);
  final Color textGrey = const Color(0xFF7D858D);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // --- LOGIKA VALIDASI (Mirip Register) ---
  void _handleLogin(BuildContext context) {
    String email = emailController.text.trim();
    String password = passwordController.text; // Jangan di-trim agar spasi password terbaca

    // 1. Validasi Kosong
    if (email.isEmpty) {
      _showSnackBar(context, "Email atau Nomor Telepon tidak boleh kosong");
      return;
    }
    if (password.isEmpty) {
      _showSnackBar(context, "Kata sandi tidak boleh kosong");
      return;
    }

    // 2. Validasi Format Email (Hanya jika user input email, bukan nomor telp)
    if (email.contains('@') && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      _showSnackBar(context, "Format email tidak valid");
      return;
    }

    // 3. Validasi Kekuatan Password (Samakan dengan kriteria Register)
    RegExp passRegex = RegExp(r'^(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (!passRegex.hasMatch(password)) {
      _showSnackBar(context, "Password minimal 8 karakter dengan kombinasi huruf besar, angka, dan simbol(!@#\$&*)");
      return;
    }

    // Jika semua lolos:
    print("Login Berhasil ke ArenaHub: $email");
    // Lanjut ke navigasi Dashboard/Home
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              
              // --- HEADER ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(color: primaryBlue, shape: BoxShape.circle),
                        child: const Center(child: Icon(Icons.sports_soccer, color: Colors.white, size: 22)),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Arena", style: TextStyle(color: navyDark, fontSize: 18, height: 1.1)),
                          Text("Hub", style: TextStyle(color: navyDark, fontSize: 18, fontWeight: FontWeight.bold, height: 1.1)),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.help_outline, color: navyDark, size: 28),
                ],
              ),

              const SizedBox(height: 32),

              // --- BANNER IMAGE ---
              // (Tetap menggunakan Placeholder jika asset belum ada)
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 342,
                    height: 224,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        'assets/images/sports_collage.png', // <--- Pastikan nama file ini sesuai di pubspec.yaml
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(
                              height: 224, 
                              color: Colors.grey[300], 
                              child: const Icon(Icons.image, size: 50, color: Colors.grey)
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              Center(
                child: Text("Selamat Datang Kembali!", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: navyDark)),
              ),
              const SizedBox(height: 8),
              Center(child: Text("Masuk ke akun ArenaHub Anda", style: TextStyle(color: textGrey, fontSize: 15))),

              const SizedBox(height: 32),

              // --- FORM INPUT ---
              _buildLabel("Email atau Nomor Telepon"),
              const SizedBox(height: 8),
              _buildShadowedInput(
                controller: emailController,
                hintText: "Contoh: user@email.com",
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 20),

              _buildLabel("Kata Sandi"),
              const SizedBox(height: 8),
              _buildShadowedInput(
                controller: passwordController,
                hintText: "Masukkan kata sandi",
                icon: Icons.lock_outline,
                obscure: _obscurePassword,
                suffix: _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                onSuffixPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),

              const SizedBox(height: 12),
              /// --- NAVIGASI LUPA KATA SANDI ---
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    // Navigasi ke halaman Lupa Kata Sandi
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                    );
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Text(
                      "Lupa Kata Sandi?",
                      style: TextStyle(
                        color: accentGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // --- LOGIN BUTTON ---
              _buildLoginButton(),

              const SizedBox(height: 32),

              // --- DIVIDER ---
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[300])),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text("atau", style: TextStyle(color: textGrey))),
                  Expanded(child: Divider(color: Colors.grey[300])),
                ],
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialButton("G"),
                  const SizedBox(width: 20),
                  _socialButton("f"),
                ],
              ),

              const SizedBox(height: 35),

              // --- FOOTER ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum punya akun? ", style: TextStyle(color: textGrey)),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen())),
                    child: Text("Daftar sekarang", style: TextStyle(color: accentGreen, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),

              const SizedBox(height: 40),
              Center(child: Text("© 2026 ARENAHUB INDONESIA", style: TextStyle(color: Colors.grey[400], fontSize: 11, letterSpacing: 1.2))),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPERS ---

  Widget _buildLabel(String text) {
    return Text(text, style: TextStyle(color: textGrey, fontWeight: FontWeight.w600, fontSize: 14));
  }

  Widget _buildShadowedInput({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscure = false,
    IconData? suffix,
    VoidCallback? onSuffixPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: icon == Icons.email_outlined 
            ? TextInputType.emailAddress 
            : TextInputType.text,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: textGrey.withOpacity(0.6)),
          prefixIcon: Icon(icon, color: textGrey),
          suffixIcon: suffix != null ? IconButton(icon: Icon(suffix, color: textGrey), onPressed: onSuffixPressed) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: primaryBlue.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        onPressed: () => _handleLogin(context),
        child: const Text("Masuk", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _socialButton(String label) {
    return Container(
      width: 60, height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Center(child: Text(label, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
    );
  }
}