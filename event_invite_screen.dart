import 'package:flutter/material.dart';
import 'create_event_screen.dart';

class EventInviteScreen extends StatelessWidget {
  final String nomeEvento;
  final String dataEvento;
  final String horarioEvento;
  final String localEvento;
  final String descricaoEvento;

  const EventInviteScreen({
    super.key,
    required this.nomeEvento,
    required this.dataEvento,
    required this.horarioEvento,
    required this.localEvento,
    required this.descricaoEvento,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convite do Evento'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Editar Evento',
            onPressed: () {
              // Volta para a tela de criação/edição do evento
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateEventScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nomeEvento,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('📅 Data: $dataEvento', style: const TextStyle(fontSize: 18)),
            Text(
              '⏰ Horário: $horarioEvento',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              '📍 Local: $localEvento',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Descrição:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(descricaoEvento, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Presença confirmada!')),
                    );
                  },
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Confirmar Presença'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ausência registrada.')),
                    );
                  },
                  icon: const Icon(Icons.cancel_outlined),
                  label: const Text('Ausência'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.redAccent,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    // Aqui poderia abrir um compartilhamento nativo, mas deixamos uma simulação
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Convite enviado!')),
                    );
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('Enviar Convite'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
