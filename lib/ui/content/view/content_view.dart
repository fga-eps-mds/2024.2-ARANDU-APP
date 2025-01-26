import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aranduapp/ui/content/viewmodel/content_viewmodel.dart';
import 'package:flutter_html/flutter_html.dart'; // Pacote para renderizar HTML
import 'package:aranduapp/ui/home/view/home_view.dart';

class ContentView extends StatelessWidget {
  const ContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContentViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Lógica Booleana"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        body: Consumer<ContentViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                // Barra de progresso
                SizedBox(
                  height: 10.0,
                  child: LinearProgressIndicator(
                    value: viewModel.progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                // Conteúdo rolável com altura mínima garantida
                Expanded(
                  child: SingleChildScrollView(
                    controller: viewModel.scrollController,
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      // Adicionando uma altura mínima para garantir a rolagem
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context)
                            .size
                            .height, // Garante altura mínima
                      ),
                      child: Column(
                        children: [
                          _renderContent(), // Função para renderizar o conteúdo HTML
                          if (viewModel.shouldShowButton) ...[
                            // Botão "Finalizar", exibido somente quando permitido pela ViewModel
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () {
                                  _showCompletionDialog(context);
                                },
                                child: Text(
                                  'Finalizar',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.apply(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Função para renderizar conteúdo HTML
  Widget _renderContent() {
    String htmlContent = """
      <h1>Lógica Booleana</h1>
<p>A <strong>lógica booleana</strong> é uma das áreas fundamentais da matemática e da ciência da computação, sendo aplicada em diversos campos, como programação, circuitos digitais, inteligência artificial, e até mesmo no desenvolvimento de algoritmos. Criada por George Boole, um matemático britânico, no século XIX, ela fornece uma estrutura formal para raciocínios que envolvem valores lógicos e suas operações. Na sua essência, a lógica booleana lida com duas possibilidades: verdadeiro (geralmente representado por 1) e falso (geralmente representado por 0).</p>

<h2>Fundamentos da Lógica Booleana</h2>
<p>Os princípios básicos da lógica booleana estão enraizados em algumas operações lógicas fundamentais, que manipulam valores binários (verdadeiro ou falso). As três operações principais são:</p>

<h3>1. AND (E):</h3>
<p>A operação AND resulta em verdadeiro (1) apenas quando ambos os operandos são verdadeiros. Em qualquer outro caso, o resultado é falso (0). Em termos simbólicos, para duas variáveis <code>A</code> e <code>B</code>, temos:</p>
<pre><code>A AND B = 1 se A = 1 e B = 1, caso contrário A AND B = 0.</code></pre>

<h3>2. OR (OU):</h3>
<p>A operação OR resulta em verdadeiro (1) quando pelo menos um dos operandos é verdadeiro. Se ambos forem falsos, o resultado será falso. Para as variáveis <code>A</code> e <code>B</code>, temos:</p>
<pre><code>A OR B = 1 se A = 1 ou B = 1, caso contrário A OR B = 0.</code></pre>

<h3>3. NOT (NÃO):</h3>
<p>A operação NOT inverte o valor lógico de uma expressão. Ou seja, ela transforma verdadeiro em falso e vice-versa. Para uma variável <code>A</code>, temos:</p>
<pre><code>NOT A = 1, se A = 0; 0, se A = 1.</code></pre>

<p>Essas operações podem ser combinadas de várias formas para construir expressões mais complexas, representando relações lógicas entre diferentes variáveis.</p>


<h2>Aplicações Práticas da Lógica Booleana</h2>
<p>A lógica booleana tem inúmeras aplicações práticas em diversas áreas da ciência e engenharia, particularmente na computação. Aqui estão algumas das suas principais aplicações:</p>

<h3>1. Circuitos Digitais:</h3>
<p>Os circuitos digitais, que são a base dos computadores modernos e outros dispositivos eletrônicos, funcionam com lógica booleana. Combinando portas lógicas (como AND, OR, NOT), é possível construir circuitos que realizam operações matemáticas e lógicas, processando dados binários (0s e 1s).</p>

<h3>2. Programação de Computadores:</h3>
<p>Na programação, a lógica booleana é frequentemente usada para realizar verificações condicionais. Em linguagens como C, Java, Python e muitas outras, podemos usar expressões booleanas para decidir qual caminho um programa deve seguir, com base em condições como "se" ou "caso contrário". Por exemplo:</p>
<pre><code>if (x > 0 and y < 10):
    print("Condição satisfeita")</code></pre>

<h3>3. Busca e Filtragem de Dados:</h3>
<p>Em sistemas de busca e bancos de dados, a lógica booleana é usada para construir consultas que retornem dados que atendem a múltiplas condições. Por exemplo, ao buscar por informações em um banco de dados, podemos usar operadores como AND e OR para combinar palavras-chave, ou NOT para excluir determinados termos.</p>

<h3>4. Sistemas de Inteligência Artificial:</h3>
<p>A lógica booleana também é aplicada em inteligência artificial para tomar decisões com base em condições específicas. Em sistemas de aprendizado de máquina, decisões e classificações podem ser feitas usando lógica booleana, onde a entrada é analisada e uma decisão binária (verdadeira ou falsa) é tomada.</p>

<h3>5. Automatização e Controle:</h3>
<p>Em sistemas de controle, como os utilizados na automação industrial, a lógica booleana permite criar condições para acionar ou desativar máquinas e processos. Por exemplo, um sistema pode ser projetado para iniciar um motor apenas quando certas condições lógicas forem atendidas.</p>

<h2>Teorema de De Morgan</h2>
<p>Os teoremas de De Morgan são regras importantes na lógica booleana que permitem simplificar expressões lógicas. Eles são expressos como:</p>

<h3>1. A negação de uma conjunção é igual à disjunção das negações:</h3>
<pre><code>¬(A AND B) = ¬A OR ¬B</code></pre>

<h3>2. A negação de uma disjunção é igual à conjunção das negações:</h3>
<pre><code>¬(A OR B) = ¬A AND ¬B</code></pre>

<p>Esses teoremas são úteis na simplificação de expressões booleanas complexas, especialmente quando se trabalha com circuitos lógicos e programação.</p>

<h2>Conclusão</h2>
<p>A lógica booleana é uma ferramenta poderosa e essencial em muitas áreas da matemática e da ciência da computação. Desde a construção de circuitos digitais até a programação de algoritmos e a inteligência artificial, ela desempenha um papel crucial na construção de sistemas eficientes e funcionais. Compreender os princípios da lógica booleana é fundamental para quem deseja se aprofundar em áreas como programação, design de sistemas e automação, pois fornece a base para tomar decisões, realizar operações e construir soluções tecnológicas complexas.</p>
    """;

    // Renderiza o conteúdo HTML
    return Html(
      data: htmlContent,
    );
  }

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: 250,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Conteúdo Finalizado! Voltando para a trilha.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.apply(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .primary, // Cor laranja para o botão
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeView()),
                      (Route<dynamic> route) =>
                          false, // Limpa a pilha de navegação
                    );
                  },
                  child: Text(
                    'Trilha',
                    style: Theme.of(context).textTheme.bodyLarge?.apply(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
