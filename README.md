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

# Dockerfile Básico e Instruções
## Anatomia de um Dockerfile
- Um arquivo de texto que contém instruções e argumentos;
- Sequência de instruções executadas em ordem para construir uma imagem Docker;
- Cada instrução cria uma nova camada na imagem, quando aplicável.

As instruções do Dockerfile tem a sintaxe `INSTRUÇÃO argumentos`. As instruções podem até ser escritas em minúsculo (o docker build vai entender), mas o padrão é que as instruções sejam escritas com letras maiúsculas.

## Cmd Vs Entrypoint
### CMD
Define o comando padrão executado quando o container é iniciado. Apenas o último CMD é considerado. 

Temos duas formas para o CMD: `shell` ou `exec`.
```sh
# forma exec
CMD ["python", "app.py"]
# forma shell
CMD python app.py
```

O CMD só entra em cena quando executamos o comando `docker run`.

Ao rodar o container, você pode substituir o CMD usado:
```sh
# Note que o bash é o executável que substitui o CMD definido.
docker run minha-imagem bash
```

Vamos exemplificar com uma imagem Python: 
```sh
docker run -d python:alpine
# f8a2c7ceddb661c3e70de69b4494fa340a9000e18d209d782e6fc519683420ed

docker ps -a
# CONTAINER ID   IMAGE           COMMAND                  CREATED          STATUS                      PORTS      NAMES
# f8a2c7ceddb6   python:alpine   "python3"                16 seconds ago   Exited (0) 15 seconds ago              adoring_wilson
```
> Note que o resultado do `docker ps -a` também mostra o comando executado por cada container (no exemplo, o CMD foi `python3`).

Vamos sobrescrever o comando padrão, trocando `python3` por apenas `python`:
```sh
docker run -d python:alpine python
#4a97d447a0e50dc562ebaeab0bbf33a231950bf1d4480ba05797701fab9bb005

docker ps -a
# CONTAINER ID   IMAGE           COMMAND                  CREATED         STATUS                     PORTS      NAMES
# 4a97d447a0e5   python:alpine   "python"                 8 seconds ago   Exited (0) 7 seconds ago              friendly_brown
# f8a2c7ceddb6   python:alpine   "python3"                2 minutes ago   Exited (0) 2 minutes ago              adoring_wilson
```
### ENTRYPOINT
Configura o executável principal do container. Argumentos passados via `docker run` são anexados ao ENTRYPOINT (na forma exec).

Temos duas formas para o ENTRYPOINT: `shell` ou `exec`.
```sh
# forma exec
ENTRYPOINT ["python", "app.py"]
# forma shell
ENTRYPOINT python app.py
```

É possível combinar ENTRYPOINT com CMD, sendo que o ENTRYPOINT será o executável obrigatório, enquanto o CMD vai conter os parâmetros para o ENTRYPOINT:

```sh
# Dockerfile de minha-imagem:
ENTRYPOINT ["python"]
CMD ["app.py"]
```
```sh
# Execução da imagem minha-imagem:
docker run minha-imagem
# Resultado = python app.py
```

## Instrucões Principais do Dockerfile
### FROM
Toda construção começa com a instrução FROM, que define a imagem base a partir da qual a nova imagem será construída. 

É possível usar múltiplas instruções FROM para builds multi-stage.

```sh
FROM python:3.12
```

### RUN
Executa comandos durante o build da imagem. Cada comando RUN cria uma nova camada no container.

Temos duas formas para o RUN: `shell` ou `exec`.

A sintaxe `shell` permite usar operadores, expansão de variáveis etc.
```sh
# forma shell
RUN apk update && apk add curl
```

A sintaxe `exec` exige um array JSON válido. O comando é executado diretamente, sem passar por um shell.
```sh
# forma exec
RUN ["apk", "add", "curl"]
```

Comparando as duas formas:
```sh
# forma exec
RUN ["apk", "add", "curl"]
# forma shell
RUN apk add curl
```

### COPY
Copia arquivos ou diretórios para o sistema de arquivos da imagem. Isso é realizado durante o processo de build.

Sintaxe:
```sh
COPY <origem> <destino>
# Exemplo: cópia do arquivo app.py do contexto atual 
# para o diretório /app do container:
COPY app.py /app/app.py
```

### ADD
Adiciona arquivos ao sistema de arquivos da imagem durante o build. Se parece com o COPY, mas tem funcionalidades adicionais.

Sintaxe:
```sh
ADD <origem> <destino>
# Exemplo: cópia do arquivo app.py do contexto atual 
# para o diretório /app do container:
ADD app.py /app/app.py
```

Quando usar ADD?
- Extração automática de arquivos tar locais;
- Download de arquivos via URL.

Exemplo:
```sh
ADD archive.tar.gz /app/
# Resultado: o arquivo é extraído para /app/, 
# não é apenas copiado como arquivo compactado.

ADD https://example.com/file.txt /app/file.txt
# Resultado: o Docker baixará o arquivo e o colocará no destino.
```
### WORKDIR
Define o diretório de trabalho para as instruções que vêm depois dele no Dockerfile. Se o diretório não existir no container, ele é criado automaticamente.

Sintaxe:
```sh
WORKDIR /app
# Resultado: toda instrução que vier depois será 
# executada dentro de /app.

# Exemplo sem WORKDIR (note como é verboso):
COPY app.py /app/app.py
RUN cd /app && python app.py

# Exemplo com WORKDIR (note como é conciso):
WORKDIR /app
COPY app.py .
RUN python app.py
```

## Cmd Vs Entrypoint (Prática)
### Criando uma imagem contendo apenas um CMD
Vamos construir uma imagem a partir do seguinte Dockerfile:
```sh
FROM python:alpine
WORKDIR /app
COPY app.py .
CMD ["python", "app.py"]
```

O arquivo `app.py` vai conter apenas o comando `print('Olá, mundo!')`.

Terminado o Dockerfile, vamos construir uma imagem cuja tag será `app-py`:
```sh
docker build -t app-py -f Dockerfile .
```
> A flag `-f` é opcional caso o Dockerfile tenha o nome `Dockerfile`.

Criada a image, nós a executamos:
```sh
docker run app-py
# Resultado: 
# Olá, mundo!
```

Vamos ver a lista de containers:
```sh
docker ps -a
# CONTAINER ID   IMAGE         COMMAND                  CREATED         STATUS                     PORTS      NAMES
# 4a334ee02efd   app-py        "python app.py"          3 seconds ago   Exited (0) 2 seconds ago              kind_bardeen
```

### Sobrescrevendo o CMD do Dockerfile
Vamos acrescentar ao container o arquivo `app2.py`, cujo conteúdo será apenas o comando `print('Rodando aplicação 2.')`.

O Dockerfile vai ter a seguinte configuração:
```sh
FROM python:alpine
WORKDIR /app
COPY app.py .
COPY app2.py .
CMD ["python", "app.py"]
```

Agora, vamos repetir o processo de build:
```sh
docker build -t app-py .
```

Vamos sobrescrever o CMD principal:
```sh
docker run app-py               
# Olá, mundo!

docker run app-py python app2.py
# Rodando aplicação 2.

docker ps -a
# CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS                      PORTS      NAMES
# dad240e68ee1   app-py         "python app2.py"         6 seconds ago    Exited (0) 4 seconds ago               adoring_dubinsky
# ae3333b109a5   app-py         "python app.py"          28 seconds ago   Exited (0) 26 seconds ago              vigilant_rosalind
```
> Veja a coluna COMMAND: uma executa `python app.py` e outra executa `python app2.py`.

### Usando o ENTRYPOINT
O Dockerfile vai ter a seguinte configuração para forçar o uso do ENTRYPOINT `python`:
```sh
FROM python:alpine
WORKDIR /app
COPY app.py .
COPY app2.py .
ENTRYPOINT ["python"]
CMD ["app.py"]
```

Agora, vamos repetir o processo de build e sobrescrever o CMD principal:
```sh
docker build -t app-py .

docker run app-py
# Olá, mundo!

docker run app-py app2.py
# Rodando aplicação 2.

docker ps -a
# CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS                      PORTS      NAMES
# 5937ecaec55a   app-py        "python app2.py"         17 seconds ago   Exited (0) 16 seconds ago              compassionate_tesla
# 229ec6c0b395   app-py        "python app.py"          25 seconds ago   Exited (0) 23 seconds ago              boring_moser
```
> Veja que, na coluna COMMAND, o valor do ENTRYPOINT do Dockerfile sempre foi prefixado ao comando CMD executado.
 
## Para saber mais: camadas em imagens docker
### Entendendo as camadas
Durante o processo de build, o Docker cria uma imagem composta por várias camadas empilhadas. Cada instrução do Dockerfile (como FROM, COPY e RUN) gera uma camada nova. Esse mecanismo permite que alterações em partes específicas do Dockerfile não forcem a recompilação total da imagem, já que as camadas inalteradas podem ser reutilizadas a partir do cache.

### Funcionamento interno
Quando um comando é executado durante o build, o Docker registra as alterações realizadas no sistema de arquivos da imagem. Essas alterações, por exemplo, incluir a cópia de um arquivo ou a instalação de um pacote, são salvas em uma camada separada. Ao final do build, a imagem final é a junção de todas essas camadas. Assim, se apenas um comando modificar algum arquivo, somente a camada correspondente será alterada, mantendo as demais inalteradas.

### Vantagens do uso de camadas
Uma das principais vantagens é a eficiência proporcionada pelo cache. No momento em que o Docker detecta que uma camada não sofreu alterações, ele a reutiliza ao invés de reconstruí-la. Isso acelera o processo de build e diminui o consumo de recursos. Outra vantagem é a facilidade para versionar e distribuir imagens, já que cada camada é identificada de forma única, permitindo comparações e rastreamento de mudanças.

### Considerações sobre otimização
Para tirar máximo proveito do cache, recomenda-se:

- Organizar o Dockerfile de forma que as instruções menos voláteis fiquem no início, assegurando que as camadas posteriores possam ser reutilizadas se as instruções anteriores não mudarem.
- Evitar comandos que alterem dados ou variem sua saída de forma imprevisível, pois isso gera invalidação do cache e recompilação desnecessária.

Esses cuidados ajudam a reduzir o tempo de build e melhoram a performance durante o desenvolvimento e a integração contínua.

# Persistencia e Volumes no Docker
## Criação e Gerenciamento de Volumes
Sintaxe da criação de um volume:
```sh
docker volume create NOME_VOLUME
```

Volumes podem ser listados e inspecionados:
```sh
docker volume ls
docker volume inspect cd 
# [
#     {
#         "CreatedAt": "2026-03-25T22:19:26Z",
#         "Driver": "local",
#         "Labels": null,
#         "Mountpoint": "/var/lib/docker/volumes/cd/_data",
#         "Name": "cd",
#         "Options": null,
#         "Scope": "local"
#     }
# ]
```

Remoção de volumes:
```sh
docker volume rm NOME_VOLUME
```

Há três tipos de mount usados com o comando `docker run --mount`:
1. **volume:** `docker run --mount type=volume,src=<nome-volume>,dst=<caminho-container>`
2. **bind:** `docker run --mount type=bind,src=<caminho-host>,dst=<caminho-container>`
3. **tmpfs:** `docker run --mount type=tmpfs,dst=<caminho-container>`

## Tipos de Volumes
Um mount é um mapeamento de um recurso do host para um caminho dentro do container. Há três tipos de mounts:
- Named volumes;
- Bind mounts;
- Tmpfs mounts.

Qualquer que seja o tipo de volume, os dados são vistos da mesma forma pelo container: eles serão expostos como pasta ou arquivo individual dentro do filesystem do container.

### Named volumes
- Gerenciados pelo próprio Docker;
- O Docker decide onde isso fica armazenado no host (você não precisa saber o caminho físico);
- São desacoplados do ciclo de vida do container (eles permanecem mesmo que os containers sejam destruídos);
- Ideais para banco de dados, dados persistentes de aplicações, etc;
- Docker quem gerencia permissões, estrutura e isolamento.

### Bind mounts
- Mapeia um diretório específico do seu host dentro do container;
- Você controla exatamente o caminho no host;
- O container enxerga o diretório real do sistema;
- Muito bom para desenvolvimento (edita o código no host e reflete direto no container);
- Se o diretório do host desaparecer ou mudar permissões, afeta o container imediatamente.

### Tmpfs mounts
- Armazena arquivos diretamente na memória da máquina do host;
- Dados **nunca** são gravados em disco;
- Quando o container para, dados somem;
- Quando host reinicia, dados desaparecem também;
- Útil para dados temporários, informações sensíveis ou cache de alta performance.
