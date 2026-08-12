# 🔋 Battery Monitor

Aplicativo Flutter desenvolvido como teste técnico para demonstrar conhecimentos em **Flutter, comunicação nativa, gerenciamento de estado e persistência local de dados**.

O aplicativo permite consultar o nível atual da bateria do dispositivo através de código nativo Android, armazenar cada consulta localmente e visualizar o histórico das consultas realizadas.

## 📱 Funcionalidades

* Consulta do nível atual da bateria do dispositivo.
* Comunicação entre Flutter e Android utilizando `MethodChannel`.
* Implementação nativa em Kotlin.
* Persistência local do histórico de consultas.
* Registro da porcentagem da bateria e horário da consulta.
* Gerenciamento de estado utilizando `Provider`.
* Atualização reativa da interface após uma nova consulta.
* Histórico das consultas realizadas.
* Tratamento de erros durante a comunicação com o código nativo.
* Indicador de carregamento durante operações assíncronas.

## 🛠️ Tecnologias utilizadas

* **Flutter**
* **Dart**
* **Kotlin**
* **Android SDK**
* **Provider**
* **SharedPreferences**
* **MethodChannel**

## 🏗️ Arquitetura

O projeto foi estruturado utilizando **Clean Architecture**, separando as responsabilidades entre apresentação, domínio e dados.

```text
lib/
├── core/
│   └── errors/
│
├── features/
│   └── battery/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       │
│       ├── domain/
│       │   ├── entities/
│       │   └── repositories/
│       │
│       └── presentation/
│           ├── controllers/
│           └── pages/
│
└── main.dart
```

Essa organização evita que a interface tenha acesso direto à persistência ou à implementação nativa, mantendo as responsabilidades separadas e facilitando a manutenção e evolução do projeto.

## 🔌 Comunicação nativa

A comunicação entre Flutter e Android é realizada através de um `MethodChannel`.

### Flutter

O Flutter solicita o nível atual da bateria utilizando o canal configurado para comunicação com o código nativo.

### Android / Kotlin

No código nativo é utilizado o `BatteryManager` do Android para obter o percentual atual da bateria.

### Fluxo

```text
Flutter
   ↓
Controller (Provider)
   ↓
Repository
   ↓
MethodChannel
   ↓
Kotlin
   ↓
BatteryManager
   ↓
Retorno para o Flutter
```

Essa abordagem foi escolhida porque o objetivo do teste é demonstrar conhecimento de comunicação entre Flutter e código nativo, sem utilizar pacotes prontos para consulta da bateria.

## 🔄 Gerenciamento de estado

Foi utilizado o **Provider** para o gerenciamento do estado da aplicação.

O controller é responsável por:

* Carregar o histórico ao iniciar a aplicação.
* Controlar o estado de carregamento.
* Solicitar uma nova leitura da bateria.
* Salvar uma nova consulta.
* Atualizar a lista de histórico de forma reativa.
* Notificar a interface quando o estado for alterado.

Dessa forma, a tela de histórico é atualizada automaticamente quando uma nova consulta é realizada, sem necessidade de recarregar manualmente a tela.

## 💾 Persistência local

Para armazenamento local foi utilizado o **SharedPreferences**.

O aplicativo armazena o histórico das consultas realizadas contendo:

* Nível da bateria.
* Data da consulta.
* Horário da consulta.

Os registros são armazenados considerando o **fuso horário local**, garantindo que as informações apresentadas ao usuário correspondam ao horário do dispositivo.

Os dados permanecem disponíveis mesmo após o fechamento e reabertura do aplicativo.

## 📲 Telas

### Home

Tela principal da aplicação contendo:

* Botão para consultar a bateria.
* Exibição do nível atual da bateria.
* Indicador de carregamento durante a consulta.
* Feedback de possíveis erros.

### Histórico

Tela dedicada à exibição de todas as consultas realizadas, apresentando o nível da bateria e a respectiva data e horário.

Caso não existam registros, é apresentada uma mensagem informando que o histórico está vazio.

## ⚠️ Tratamento de erros

A aplicação possui tratamento de erros para evitar encerramentos inesperados durante as operações assíncronas.

Entre os cenários considerados estão:

* Falha na comunicação através do `MethodChannel`.
* Erro durante a consulta da bateria no código nativo.
* Falha durante a persistência dos dados.
* Ausência de dados retornados pelo código nativo.

## 🚀 Como executar o projeto

### Pré-requisitos

* Flutter SDK
* Android Studio
* Android SDK
* Android Emulator configurado ou dispositivo Android físico
  

### Passo a passo

#### 1. Clone o repositório

```bash
git clone https://github.com/SEU_USUARIO/app_bateria.git
```

#### 2. Entre na pasta do projeto

```bash
cd app_bateria
```

#### 3. Instale as dependências

```bash
flutter pub get
```

#### 4. Verifique o ambiente

```bash
flutter doctor
```

#### 5. Verifique os dispositivos disponíveis

```bash
flutter devices
```

#### 6. Execute o aplicativo

```bash
flutter run
```

## 🧪 Testando a aplicação

Após iniciar o aplicativo:

1. Acesse a tela **Home**.
2. Toque no botão **Consultar Bateria**.
3. Verifique o nível atual da bateria.
4. Acesse a tela **Histórico**.
5. Verifique se a consulta foi registrada.
6. Feche e abra novamente o aplicativo.
7. Verifique se o histórico continua disponível.

### Teste utilizando o Android Emulator

Ao executar através do emulador do Android Studio, é possível simular diferentes níveis de bateria através dos controles estendidos:

```text
Extended Controls (...)
        ↓
Battery
        ↓
Charge level
```

Isso permite testar diferentes cenários de consulta sem depender exclusivamente do nível real da bateria do computador ou dispositivo.

## 🎯 Objetivo técnico

O projeto foi desenvolvido com foco na demonstração dos seguintes conhecimentos:

* Desenvolvimento de aplicações Flutter.
* Comunicação Flutter ↔ Android.
* Implementação de `MethodChannel`.
* Desenvolvimento nativo utilizando Kotlin.
* Gerenciamento de estado com Provider.
* Persistência local com SharedPreferences.
* Clean Architecture.
* Programação assíncrona.
* Reatividade da interface.
* Tratamento de erros.
* Separação de responsabilidades.

## 👨‍💻 Autor

**João Arthur**

Desenvolvedor Flutter Pleno
