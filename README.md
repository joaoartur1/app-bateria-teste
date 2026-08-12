# 🔋 App Bateria

Este projeto é um aplicativo mobile construído em Flutter para monitorar o nível de bateria do dispositivo. Desenvolvido como parte de um teste técnico, o aplicativo demonstra a integração entre o framework Flutter e os recursos nativos do sistema operacional, além de aplicar persistência de dados local.

## 🛠️ Tecnologias e Padrões Utilizados

*   **Frontend:** Flutter & Dart
*   **Integração Nativa:** Kotlin (Android) utilizando `MethodChannel` para acessar a API de bateria do sistema.
*   **Gerenciamento de Estado:** `Provider`
*   **Armazenamento Local:** `SharedPreferences` para manter o histórico de consultas salvo no dispositivo.
*   **Arquitetura:** Clean Architecture (Arquitetura Limpa).

## 🏗️ Estrutura do Projeto (Clean Architecture)

O projeto foi organizado em camadas para garantir a separação de responsabilidades, facilitando a escalabilidade e a manutenção do código:

```text
lib/
└── features/
    └── battery/
        ├── data/
        │   ├── datasources/    # Fontes de dados (MethodChannel nativo e Cache local)
        │   └── repositories/   # Implementação dos contratos de acesso a dados
        ├── domain/
        │   ├── entities/       # Entidades de negócio (ex: BatteryRecord)
        │   └── repositories/   # Interfaces/Contratos
        └── presentation/
            ├── controllers/    # Controladores de estado (Provider)
            └── pages/          # Interface de Usuário (Home e Histórico)

🚀 Funcionalidades
Consulta em Tempo Real: Solicita o nível atual de bateria diretamente do hardware/sistema operacional Android.

Histórico Local: Cada consulta é salva com data e hora exatas, permanecendo disponível mesmo após o fechamento do aplicativo.

Navegação Fluida: Interface dividida em abas (Bateria e Histórico) para melhor usabilidade.

⚙️ Como Executar
Pré-requisitos:

Flutter SDK

Android Studio com emulador configurado (ou dispositivo físico)

Java JDK 17 (padrão recomendado para as compilações mais recentes do Gradle)

Passo a passo:

Clone este repositório no seu ambiente local.

Abra o terminal na raiz do projeto e baixe as dependências:

Bash
flutter pub get

Inicie o aplicativo:

Bash
flutter run

Nota: Ao testar via emulador do Android Studio, você pode simular diferentes níveis de bateria acessando Extended Controls (...) > Battery > Charge level.