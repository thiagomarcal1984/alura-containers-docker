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

## Para saber mais: docker libcontainer e RunC

### Contextualização Histórica
Antes da consolidação dos padrões de contêineres, o Docker passava por uma fase de transição importante. Nesta etapa, surgiu o LibContainer, uma biblioteca de execução desenvolvida para oferecer maior controle e flexibilidade na gestão dos recursos do sistema. Ele permitia que os conceitos dos cgroups e namespaces, já disponíveis no kernel Linux, fossem integrados de forma mais direta e modulada, facilitando o isolamento e a limitação de recursos para cada contêiner.

### Funcionamento do LibContainer
A ideia por trás do LibContainer era abstrair o processo de manipulação de recursos do sistema, de modo que o gerenciamento dos contêineres ficasse mais padronizado e menos dependente de patches ou modificações diretas no kernel. Essa biblioteca fazia a ponte entre as funcionalidades nativas do Linux e a aplicação que gerenciava os contêineres, delegando automaticamente tarefas como a alocação de memória, o controle de CPU e a organização dos espaços de nomes. Esse design modular permitia um ambiente de contêiner mais resiliente e preparado para escalabilidade, mesmo em cenários onde os recursos eram compartilhados entre processos isolados.

### A Transição para o RunC
Com o avanço das tecnologias de contêiner, a necessidade por uma ferramenta mais padronizada e que seguisse as especificações de uma iniciativa global levou à evolução do LibContainer para o RunC. O RunC foi desenvolvido para funcionar como uma ferramenta de linha de comando leve, permitindo a execução dos contêineres conforme diretrizes definidas pela Open Container Initiative (OCI). Essa mudança não só melhorou a interoperabilidade entre diferentes plataformas, mas também incentivou a criação de um ecossistema mais robusto e colaborativo, já que outras soluções passaram a adotar o mesmo padrão de execução.

### Exemplificando com Código
Para ilustrar, veja um exemplo básico de como o RunC pode ser invocado para iniciar um contêiner:

```bash 
runc run my-container-id
``` 

Este comando utiliza o RunC para iniciar um contêiner com o identificador definido, demonstrando a simplicidade e a eficácia da ferramenta na prática.

### Impacto na Padronização
A consolidação do RunC representou um marco na evolução dos contêineres. Ao oferecer uma camada nativa e padronizada para a execução dos contêineres, ele contribuiu para que desenvolvedores e profissionais de DevOps pudessem contar com um ambiente confiável e consistente, independentemente da plataforma ou da ferramenta utilizada anteriormente. Assim, a transição do LibContainer para o RunC facilitou a integração entre ferramentas, acelerou o desenvolvimento de novas soluções e reforçou a confiança na tecnologia de contêineres para ambientes de produção.

# Comandos e Ciclo de Vida
## Ciclo de vida de um container
Containers são processos. Cada container roda um processo principal, e se esse processo morre, o container morre também.

Os containers foram feitos para morrer. O CV de um container é semelhanteao CV de um processo. 

Os estados dos processos são:
- created;
- running;
- paused;
- stopped; e
- removed.

O estados principais dos container são:
- **created:** container foi criado, mas o processo principal ainda não foi iniciado;
- **running:** processo principal do container está ativo;
- **paused:** container está congelado (suspende os processos);
- **restarting:** container terminou, mas existe uma política de restart configurada; 
- **exited:** o processo principal terminou, o container ainda existe, mas não está executando; e 
- **dead:** container tentou ser removido, mas o docker não conseguiu finalizar completamente (é raro).

### Create vs Run
- `docker create` apenas cria;
- `docker run` cria e inicia o container (create + start).

### Remoção
Um container parado continua existindo. A remoção do container precisa ser explícita, com o comando `docker rm`.

## Comandos básicos do docker cli
O Docker CLI é a interface de linha de comando do Docker usada para conversar com o Docker Daemon.

A estrutura do comando do Docker CLI seria:
```bash
docker [objeto] [acao]
```
> Exemplos:
> ```bash
> docker container ls
> docker image ls
> docker volume ls
> ```

Quando executamos, por exemplo, o comando `docker run hello-world`, o Docker:
- procura a imagem localmente;
- se não houver, baixa do Registry (Docker Hub);
- cria o container;
- executa o processo e destrói o container após o seu fim.

Após a execução do container `hello-world`, podemos ver os containers **em execução** com o comando:
```sh
docker container ls
```

Para mostrar todos os comandos, acrescente a flag `-a` ou `--all`:
```sh
docker container ls -a
```
> O comando `docker ps` é um alias para `docker container list` ou `docker container ls`.

## Gerenciamento de containers I
### Criando o container
Vamos começar criando um container nginx: 

```sh
docker create nginx
# Ou você pode executar:
# docker container create nginx
```

Depois de criado o container, vamos exibir a lista de containers:
```sh
docker ps -a
```

Resultado:
```
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS         PORTS      NAMES
6378801fd8cd   nginx         "/docker-entrypoint.…"   33 seconds ago   Created                   priceless_liskov
# Resultado omitido.
```

### Informações do cliente e servidor do Docker
O comando `docker info` traz a seguinte saída:
```
Client:
 Version:    29.5.3
 Context:    desktop-linux
 Debug Mode: false
 Plugins:
  ### Resultado omitido.

Server:
 Containers: 2
  Running: 1
  Paused: 0
  Stopped: 1
 Images: 20
 ### Restante do resultado omitido.
 ```
 Note que nele são mostrados os containers existentes e seus status (running, paused e stopped).

### Iniciando um container parado do Docker
Para iniciar o container, use: 
```sh
docker container start 6378801fd8cd
# Ou você pode usar a sintaxe mais breve: 
# docker start 6378801fd8cd
```

### Pausando (e despausando) um container em execução
Para pausar o container (o processo continuará ativo), use: 
```sh
docker container pause priceless_liskov
# Ou você pode usar a sintaxe mais breve: 
# docker pause priceless_liskov
```
Vamos listar os containers para ver o status do container `priceless_liskov`:
```sh
docker ps
```
Resultado:
```
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS                   PORTS      NAMES
6378801fd8cd   nginx         "/docker-entrypoint.…"   31 minutes ago   Up 52 seconds (Paused)   80/tcp     priceless_liskov
```
> Note o status `Up` e o complemento `Paused` entre parenteses.

Para "despausar" o container, use `docker container unpause nome_container` ou a versão resumida `docker unpause priceless_liskov`.

### Parando um container
Para parar o container (e o seu respectivo processo), use: 
```sh
docker container stop priceless_liskov
# Ou você pode usar a sintaxe mais breve: 
# docker stop priceless_liskov
```

Listando todos os containers para mostrar o status deles: 
```sh
docker ps -a
```
Resultado:
```
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS                     PORTS      NAMES
6378801fd8cd   nginx         "/docker-entrypoint.…"   39 minutes ago   Exited (0) 2 seconds ago              priceless_liskov
```
> Note o status `Exited`.

### Atribuindo nomes aos containers ao criá-los
Forneça a flag `--name` para definir o nome do container ao criá-lo:
```sh
docker container create --name alura nginx
# Ou você pode usar a sintaxe mais breve: 
# docker create --name alura nginx
```
Listando todos os containers para mostrar o status deles: 
```sh
docker ps -a
```
Resultado:
```
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS                     PORTS      NAMES
196f693f83c8   nginx         "/docker-entrypoint.…"   6 seconds ago    Created                               alura
6378801fd8cd   nginx         "/docker-entrypoint.…"   44 minutes ago   Exited (0) 5 minutes ago              priceless_liskov
```

### Reiniciando um container
Para reiniciar um container (stop + start), execute o comando:
```sh
docker container restart alura
# Ou você pode usar a sintaxe mais breve: 
# docker restart alura
```
### Rodando um container
Para rodar um container (create + start), use o comando: 
```sh
docker container run --name container-run nginx
# Ou você pode usar a sintaxe mais breve: 
# docker run --name container-run nginx
```
O resultado é a execução do processo do container, mas também o travamento do terminal.  É necessário usar o comando <kbd>Ctrl</kbd> + <kbd>c</kbd> para parar o processo (e liberar o terminal).

Executando o `docker ps -a`, você verá o container `container-run` com o status `Exited`:
```
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS                      PORTS      NAMES
478953f44f82   nginx         "/docker-entrypoint.…"   5 minutes ago    Exited (0) 48 seconds ago              container-run
```

### Removendo um container
Para remover um container, use o comando:
```sh
docker container rm container-run
# Ou você pode usar a sintaxe mais breve: 
# docker rm container-run
```
Somente containers com o status de `Exited` podem ser removidos. Se executarmos o comando `docker rm alura`, teremos como resultado:
```
Error response from daemon: cannot remove container "alura": container is running: stop the container before removing or force remove
```

Para forçar a remoção, use a flag `-f`:
```sh
docker rm -f alura
```

Você pode remover mais de um container por vez:

```sh

docker create nginx
# 96d7230f5b8510a4c420d8ff7a7019d71b2ee46ccc99fec21254208140cbd08a

docker create nginx
# c51fce18709c4e176e2b66c9f48805c193dfc20b31825d65b532bb9e9000810f

docker ps -a
# CONTAINER ID   IMAGE         COMMAND                  CREATED             STATUS                      PORTS      NAMES
# c51fce18709c   nginx         "/docker-entrypoint.…"   12 seconds ago      Created                                competent_allen
# 96d7230f5b85   nginx         "/docker-entrypoint.…"   14 seconds ago      Created                                sleepy_jemison

docker rm c51fce18709c 96d7230f5b85
# c51fce18709c
# 96d7230f5b85
```

## Gerenciamento de containers II
### docker create
Com este comando, o Docker cria a estrutura do container a partir de uma imagem. Ele monta o filesystem, configura a rede, namespace e cgroups. Esse comando não executa o processo principal ainda.

### docker start
Este comando inicia um container que já existe e está parado. Ele não cria um novo container, apenas inicia um container já criado. A configuração original é mantida.

### docker run
Este comando cria e inicia o container, executando o seu processo principal.

### docker pause
Após a execução deste comando, o container continua existindo e seus processos continuam na memória. O docker congela a execução usando cgroups (freeze cgroup). O processo fica suspenso, não finalizado.

### docker unpause
O container continua a execução de onde parou.

### docker stop
Envia um sinal de parada para o processo principal do container. O processo é finalizado. Isso permite que aplicações fechem conexões, salvem estado etc.

### docker restart
Equivale a `docker stop` + `docker start`. Usado quando o app trava, em testes de comportamento etc. Ele reinicia o processo isolado, não recria o container.

### docker rm
Remove containers parados. A imagem associada ao container não é removida. Para forçar a remoção de um container em execução, use a flag `-f`.

### Mentalidade correta
Containers são efêmeros: não os trate como servidores permanentes. Se um container der problema ou precisar de atualização, remova-o e suba outro.

## Para saber mais: como o Docker gera nomes aleatórios

### Origem dos Nomes Aleatórios
Quando não definimos um nome específico para um container, o Docker recorre a um gerador interno para fornecer um nome único e memorável. Esse mecanismo evita que haja colisão de nomes e facilita a identificação de containers sem que precisemos criar um sistema de nomenclatura manual.

### O Algoritmo por Trás da Nomeação
O algoritmo utiliza uma combinação de palavras pré-definidas. Geralmente, são selecionados dois termos – normalmente um adjetivo e um nome de cientista ou personalidade famosa – que, juntos, formam um nome único, como por exemplo, `inspiring_morse` ou `loving_einstein`. O uso dessa estratégia torna os nomes mais legíveis e até divertidos, em comparação a uma sequência aleatória de caracteres.

### Implicações no Gerenciamento de Containers
Utilizar nomes aleatórios pode ser útil para identificar containers em ambientes de teste ou desenvolvimento, onde o foco está na efemeridade dos processos. Por outro lado, em ambientes de produção ou onde há necessidade de monitoramento detalhado, adotar nomes personalizados pode facilitar a manutenção e o rastreamento, evitando a confusão gerada por nomes menos intuitivos.

### Personalização Versus Automação
Embora a nomeação automática agilize a criação de containers, há situações em que definir um nome manualmente – utilizando a flag `--name` – pode trazer vantagens. Por exemplo, nomes significativos ajudam a correlacionar um container a uma função específica de uma aplicação, melhorando a comunicação entre equipes e a compreensão do ambiente.

Em resumo, enquanto o Docker oferece uma abordagem automatizada que garante unicidade e praticidade, a escolha por nomes personalizados pode tornar o gerenciamento em larga escala mais eficiente e intuitivo.
