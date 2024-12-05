import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/core/theme/app_typography.dart';
import '/core/theme/app_colors.dart';
import '/ui/register_account/viewModel/RegisterAccountViewModel.dart';

class RegisterAccount extends StatelessWidget {
  const RegisterAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterAccountViewModel(),
      child: const _RegisterAccount(),
    );
  }
}

class _RegisterAccount extends StatefulWidget {
  const _RegisterAccount({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<_RegisterAccount> {
  @override
  Widget build(BuildContext context) {
    AppColors.initialize(context);
    AppTypography.initialize(context);
    RegisterAccountViewModel viewModel = Provider.of<RegisterAccountViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.current.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Logo e título
              Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Certifique-se de usar o caminho correto
                    height: 80,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Olá,\nCrie uma conta',
                    textAlign: TextAlign.center,
                    style: AppTypography.current.titleH1.copyWith(
                      color: AppColors.current.tituloApp,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Formulário
              Form(
                key: viewModel.formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      controller: viewModel.firstNameController,
                      labelText: 'Primeiro Nome',
                    ),
                    _buildTextField(
                      controller: viewModel.lastNameController,
                      labelText: 'Último Nome',
                    ),
                    _buildTextField(
                      controller: viewModel.emailController,
                      labelText: 'Email',
                    ),
                    _buildTextField(
                      controller: viewModel.passwordController,
                      labelText: 'Password',
                      obscureText: true,
                    ),
                    _buildTextField(
                      controller: viewModel.confPasswordController,
                      labelText: 'Confirm Password',
                      obscureText: true,
                      validator: (value) => value != viewModel.passwordController.text
                          ? 'As senhas não correspondem'
                          : null,
                    ),
                    const SizedBox(height: 10),
                    // Checkbox para termos
                    Row(
                      children: [
                        Checkbox(
                          value: viewModel.isTermsAccepted,
                          onChanged: (value) {
                            viewModel.toggleTermsAccepted(value ?? false);
                          },
                        ),
                        Expanded(
                          child: Text(
                            'Para continuar, aceite os termos de privacidade e políticas de uso',
                            style: AppTypography.current.textH2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Botão de cadastro
                    ElevatedButton(
                      onPressed: () async {
                        if (viewModel.formKey.currentState?.validate() ?? false) {
                          try {
                            await viewModel.register();
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('Cadastro realizado!', style: AppTypography.current.titleH2),
                                content: Text(
                                  'Sua conta foi criada com sucesso. Faça login para continuar.',
                                  style: AppTypography.current.textH2,
                                ),
                              ),
                            );
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('Erro', style: AppTypography.current.titleH2),
                                content: Text(e.toString(), style: AppTypography.current.textH2),
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.current.tituloApp,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: viewModel.isLoading
                          ? const CircularProgressIndicator()
                          : Text(
                              'Registrar',
                              style: AppTypography.current.textH1.copyWith(color: Colors.white),
                            ),
                    ),
                    const SizedBox(height: 20),
                    // Linha divisória com "ou"
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'ou',
                            style: AppTypography.current.textH2,
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Botão de login com Google
                    OutlinedButton.icon(
                      onPressed: () {
                        // Adicione funcionalidade do Google Login
                      },
                      icon: Image.asset(
                        'assets/images/google_icon.png', // Certifique-se de usar o caminho correto
                        height: 20,
                      ),
                      label: Text('Login com Google', style: AppTypography.current.textH1),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.current.tituloApp),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Link para fazer login
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Voltar para a tela de login
                      },
                      child: Text.rich(
                        TextSpan(
                          text: 'Já tem uma conta? ',
                          style: AppTypography.current.textH2.copyWith(color: AppColors.current.text),
                          children: [
                            TextSpan(
                              text: 'faça login',
                              style: AppTypography.current.textH2.copyWith(
                                color: AppColors.current.tituloApp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: AppTypography.current.textH2.copyWith(color: AppColors.current.text),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: validator ??
            (value) => value == null || value.isEmpty ? 'Por favor, preencha este campo' : null,
      ),
    );
  }
}
