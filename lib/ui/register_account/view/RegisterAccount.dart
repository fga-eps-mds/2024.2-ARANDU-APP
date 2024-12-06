import 'package:flutter/material.dart';
import 'package:aranduapp/ui/register_account/viewModel/RegisterViewModel.dart';

class RegisterAccount extends StatelessWidget {
  final RegisterAccountViewModel viewModel = RegisterAccountViewModel();

  RegisterAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoWidget(),
                const SizedBox(height: 32),
                RegisterForm(viewModel: viewModel),
                const SizedBox(height: 16),
                RegisterButton(viewModel: viewModel),
                const SizedBox(height: 16),
                const DividerWidget(),
                const SizedBox(height: 8),
                const SocialLoginButton(),
                const SizedBox(height: 16),
                const LoginLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Arandú',
      style: TextStyle(
        fontFamily: 'Serif',
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.orange,
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  final RegisterAccountViewModel viewModel;

  const RegisterForm({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewModel.formKey,
      child: Column(
        children: [
          _buildTextField(
            controller: viewModel.firstNameController,
            label: 'Primeiro Nome',
            validator: (value) =>
                value == null || value.isEmpty ? 'Informe o primeiro nome' : null,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: viewModel.lastNameController,
            label: 'Último Nome',
            validator: (value) =>
                value == null || value.isEmpty ? 'Informe o último nome' : null,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: viewModel.emailController,
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) =>
                value == null || !value.contains('@') ? 'Informe um email válido' : null,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: viewModel.passwordController,
            label: 'Senha',
            obscureText: true,
            validator: (value) => value == null || value.length < 6
                ? 'A senha deve ter no mínimo 6 caracteres'
                : null,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: viewModel.confPasswordController,
            label: 'Confirme a Senha',
            obscureText: true,
            validator: (value) => value != viewModel.passwordController.text
                ? 'As senhas não coincidem'
                : null,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: viewModel.isTermsAccepted,
                onChanged: (value) {
                  viewModel.toggleTermsAccepted(value ?? false);
                },
              ),
              const Expanded(
                child: Text(
                  'Aceite os termos de privacidade e políticas de uso',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
    );
  }
}

class RegisterButton extends StatelessWidget {
  final RegisterAccountViewModel viewModel;

  const RegisterButton({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await viewModel.register();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cadastro realizado com sucesso!')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: viewModel.isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text('Registrar'),
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'ou',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Ação para login com Google
      },
      icon: const Icon(Icons.login),
      label: const Text('Entrar com Google'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.grey),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class LoginLink extends StatelessWidget {
  const LoginLink({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar para a página de login
      },
      child: const Text(
        'Já tem conta? Faça login',
        style: TextStyle(
          fontSize: 14,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
