`/maratona/init.sh`
```shell
#!/bin/bash
P=$(basename $PWD)
cp /maratona/template/main.cpp $P.cpp
cp /maratona/template/input*.txt .
```

`/maratona/build.sh`
```shell
#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'

ARQ="$(basename $PWD).cpp"

if [ -f main ] && [ main -nt $ARQ ]; then
    echo -e "${RED}MEU TU COMPILOU MAS NÃO MUDOU NADA, TA CERTO ISSO????${NC}"
fi

echo -e "${RED}>>> COMPILANDO: $(pwd)/$ARQ <<<${NC}"

g++ -DVINI_DEBUG -std=c++17 -O2 -Wall -Wextra -Wshadow $ARQ -o main
```

`/maratona/debug.sh` Copiar o `build.sh` mas mudar a ultima linha
```shell
g++ -DVINI_DEBUG -std=c++17 -g -Wall -Wextra -Wshadow -fsanitize=address -fsanitize=undefined $ARQ -o main
```
## Aliasses

Bom salvar pra caso tenha que refazer o terminal mas não quiser colocar no `~/.bashrc`

```shell
alias init="/maratona/init.sh"
alias build="/maratona/build.sh"
alias debug="/maratona/debug.sh"
```