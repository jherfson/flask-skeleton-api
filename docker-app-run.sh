#!/bin/bash
if [ -z $1 ] # || [ $1 != --help ] || [ $1 != --dev ] || [ $1 != --prod ]
then
    echo "Parâmetro não definido, ou incorreto, por favor utilize '--help', para ver as opções."
elif [ $1 == "--help" ]
then
    echo "Para iniciar em modo de Desenvolvimento."
    echo "  command:    ./docker-app-run.sh --dev"
    echo ""
    echo "Para iniciar ou fazer deploy em Produção."
    echo "  command:    ./docker-app-run.sh --prod"
elif [ $1 == "--dev" ]
then
    echo "#---------------ATENÇÃO---------------#"
    echo "Iniciando em modo de desenvolvimento..."
    echo ""
    echo "Desconstruindo containers, caso existam..."
    docker-compose --project-directory . -f ./docker/docker-compose-dev.yml down
    echo ""
    echo "Construindo containers de desenvolvimento..."
    docker-compose --project-directory . -f ./docker/docker-compose-dev.yml up

elif [ $1 == "--prod" ]
then
    echo "#---------------ATENÇÃO---------------#"
    echo "Fazendo deploy em ambiente de Produção."
    echo ""
    echo "Desconstruindo containers, caso existam..."
    docker-compose --project-directory . -f ./docker/docker-compose-prod.yml down
    echo ""
    echo "Construindo containers de Produção."
    docker-compose --project-directory . -f ./docker/docker-compose-prod.yml up -d --build

# Define outras opções para manipulação de containers
elif [ $1 == "--stop-all-containers" ]
then
    echo "Parando todos os containers..."
    docker stop $(docker ps -aq)

elif [ $1 == "--remove-all-containers" ]
then
    echo "Removendo todos os containers..."
    docker rm $(docker ps -aq)

elif [ $1 == "--remove-all-images" ]
then
    echo "Removendo todas as imagens..."
    docker rmi $(docker images -aq)

elif [ $1 == "--remove-all-none-images" ]
then
    echo "Removendo todas as imagens instaveis ou com tag <none>..."
    docker rmi $(docker images --filter "dangling=true" -aq)
fi
