# Fundamentos e Instalação do Docker
## O que são containers e como funcionam

Um container guarda três coisas: 

1. código-fonte;
2. dependências;
3. configurações.

Características dos containers: 

1. **isolado**: não interfere no host nem em outros containers;
2. **portátil**: roda igual em qualquer ambiente;
3. **independente**: pode ser criado ou removido sem impacto;
4. **autossuficiente**: inclui todas as dependências da aplicação.

## História e evolução dos containers
### Anos 70-90
- computadores caros e compartilhados;
- necessidade de isolar processos;
- evitar que um usuário afetasse outro.

### 1979 - chroot (Unix v7)
- chamada de sistema do Unix que muda o diretório raiz (/) de um processo;
- isolava o sistema de arquivos;
- mas não isolava rede, usuários ou CPU;
- foi uma peça conceitual importante na história dos containers;
- podemos pensar nele como um ancestral distante do que hoje fazemos com containers.

### 2000 - FreeBSD Jails
- mecanismo de isolamento do sistema operacional FreeBSD;
- vários ambientes isolados dentro do mesmo SO, compartilhando o mesmo kernel;
- separação de processos, usuários, sistema de arquivos e rede;
- é uma extensão do conceito de chroot;
- FreeBSD não é Linux; ele implementa sua própria lógica no seu próprio kernel;
- ainda era específico do BSD (Berkeley Software Distribution).

### 2001 - Linux VServer
- primeiro esforço no Linux para separar ambientes e aplicações;
- vários ambientes isolados dentro do mesmo kernel Linux, sem se enxergarem;
- funcionava através de patches do Kernel;
- precisava compilar um kernel modificado;
- configuração complexa, não tinha uma camada amigável.

### 2004 - Solaris zones
- Divide sistema Solaris em vários ambientes isolados chamados zones;
- Global Zones (sistema principal) e Non-Global zones (ambientes isolados);
- Isolamento de filesystem, redes, processos, controle de recursos;
- Criar uma nova zone podia ser quase instantâneo (impressionante para a época);
- Restrito ao ecossistema Solaris, que pertence à Oracle;
- Solaris é SO da família Unix, não é Linux.

### 2005 - OpenVZ (Open Virtuozzo)
- Divide o kernel Linux em vários ambientes isolados;
- Escala comercial - pirncipalmente para provedores de VPS (Virtual Private Servers);
- OpenVZ surgiu como um patch do kernel Linux;
- Exigia kernel modificado;
- Ferramentas próprias de administração, melhor controle de recursos e isolamento mais completo.

### 2006-2008 - cgroups e namespaces
- São mecanismos do kernel Linux que tornaram os containers possíveis;
- **cgroups (control groups):** limitam CPU, memória, I/O, número de processos;
- **namespaces**: isolam processos, rede, mount, PID.

### 2008 - LXC
- Linux Containers;
- Cria ambientes isolados dentro do sistema Linux;
- Combina Namespaces + Cgroups;
- Surge como uma evolução prática dessas features do kernel (namespaces e cgroups);
- Fornece ferramentas para criar e gerenciar containers;
- uso de recursos nativos do kernel.
### 2013 - Docker
- Inicialmente usava o LXC por baixo dos panos;
- Ficou extremamente popular, porque era simples;
- Não nasceu só como tecnologia de isolamento;
- Nasceu como **plataforma de distribuição de aplicações**.

### O que o Docker trouxe
- Imagem versionada e portátil (camadas);
- Transformou container em unidade de entrega de software;
- Foco na experiência do desenvolvedor;
- Ecossistema e Registry central;
- Todo mundo passou a usar a mesma ferramenta e compartilhar as imagens no mesmo lugar.

### 2014/2015 - Docker
- Criaram sua própria biblioteca de execução chamada **libcontainer**;
- Evolução para runtime que hoje conhecemos como runc + Padrão OCI.

### Sobre a OCI
- Open Container Iniciative;
- Organização sob Linux Foundation criada para **padronizar containers**;
- Evita fragmentação no ecossistema de containers;
- **Runtime Specification:** define como executar um container (configurações, processos etc.);
- **Image Specification**: descreve formato de empacotamento e distribuição de imagens.

### 2014 - Kubernetes
- Como rodar milhares de containers?
- Agendamento, escalabilidade;
- Containers deixam de ser locais e viram arquitetura distribuída.

### Hoje
- Serverless usa containers por baixo;
- Plataformas como serviço usam containers;
- Isolamento virou *commodity*.

## Arquitetura do docker
- arquitetura baseada em **cliente + servidor**;
- cliente Docker se comunica com daemon do Docker (dockerd).

### Docker Client
- Principal forma de interação com o Docker;
- Envia instruções para o dockerd

### Docker Daemon
- Escuta requisições API do Docker;
- Gerencia objetos Docker (imagens, containers, redes e volumes);
- Pode rodar localmente ou em outro host.

### Docker Registry
- É onde você armazena imagens docker;
- Docker Hub é o registry **padrão**;
- Temos outras opções (exemplo: ECR, ACR)

### Objetos Docker
- Docker constrói, distribui e executa aplicações em containers;
- Para fazer isso, ele manipula estruturas fundamentais;
- Essas estruturas são chamadas de objetos Docker.

#### Imagens
- Modelo imutável para criar containers;
- Contém sistema de arquivos, dependências, binários e metadados.

#### Containers
- Instância executável de uma imagem;
- Processo isolado que usa namespaces e cgroups do kernel Linux.

#### Volumes
- Mecanismos de persistência de dados;
- Permitem armazenar dados fora do ciclo de vida dos containers.

#### Redes
- Redes permitem que containers se comuniquem entre si e com o mundo externo;
- O Docker cria redes virtuais e conecta containers a elas.

## Instalação do Docker
- Docker Engine (somente para Linux);
- Docker Desktop (GUI com o Docker Engine).

### Docker Engine
- Docker CLI
- API do Docker
- Docker Daemon (dockerd)

O Docker Engine é o mecanismo principal do Docker e roda nativamente no Linux (fala direto com o kernel).

### Docker Desktop
- Aplicativo amigável. Versão "tudo em um";
- Fornece ambiente gráfico (GUI) e linha de comando para gerenciar containers Docker;
- Integração com WSL, Kubernetes e Ferramentas integradas. 

O Docker Desktop foi criado principalmente para Windows e MacOS e é composto do Docker Engine + CLI. Ele cria uma VM para esses sistemas que não tem kernel Linux.

No Linux, você não vai precisar do Docker Desktop, basta instalar o Docker Engine direto. Você pode usar o Docker Desktop se quiser simplificar a experiência.

## Diferenças entre containers e máquinas virtuais

### Estrutura do Sistema operacional
Sistema operacional é dividido em:
- **Kernel Space:** controla hardware e recursos (CPU, memória, disco, rede);
- **User Space:** é onde rodam aplicações e serviços.

### Como funciona uma máquina virtual (VM)
- Virtualiza o hardware físico;
- Cada VM tem seu próprio sistema operacional;
- Cada VM possui kernel e user space próprios.

### Como funciona um container
- Não virtualiza hardware;
- Compartilha o kernel do host;
- Isola apenas o user space das aplicações.

### Compatibilidade entre containers
- Containers compartilham o kernel do SO do host;
- O tipo de container precisa ser compatível com o kernel disponível (seja ele Windows ou Linux).

### Rodando containers Linux no Windows
- O Windows não eecuta containers Linux diretamente;
- Uma máquina virtual Linux leve é criada nos bastidores (WSL);
- Essa VM fornece o kernel Linux necessário e os containers rodam nessa VM.
