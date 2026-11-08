# Miaudota - Azure Function (Indicador de Adoção)

Azure Function (**HTTP Trigger**, Node.js 20, modelo v4, TypeScript) chamada pelo BFF em `GET /aggregated-data`. Recebe a quantidade de animais disponíveis e de feiras ativas e devolve um **indicador de oportunidade de adoção** (pontuação, nível BAIXA/MEDIA/ALTA e mensagem).

> Arquitetura de Soluções em Nuvem (PUCPR) - PJBL Miaudota - Entrega 3. Integrantes em [GRUPO.md](GRUPO.md).

## Arquitetura

A regra de negócio fica em `src/dominio/indicador.ts` (função pura, sem dependência do Azure); `src/functions/indicadorAdocao.ts` é só o adaptador HTTP. Isso permite testar a regra sem subir a Function.

Pontuação: `min(feiras, 5) * 12 + min(animais, 40)`. Nível: **ALTA** a partir de 70, **MEDIA** a partir de 35, senão **BAIXA**.

## Endpoint

`GET|POST /api/indicador-adocao?animaisDisponiveis=<n>&feirasAtivas=<n>` — `authLevel: function` (chave no cabeçalho `x-functions-key`).

## Tecnologias

Azure Functions v4, Node.js 20, TypeScript, Docker.

## Como executar

### Localmente

```bash
cp local.settings.example.json local.settings.json
npm install
npm start              # precisa do Azure Functions Core Tools (func); sobe em http://localhost:7071
```

### Imagem do Docker Hub

| Serviço | Imagem |
|---|---|
| Azure Function | `sofhiachromiec/pjbl-function:v1` |

```bash
docker run --rm -p 7071:80 sofhiachromiec/pjbl-function:v1
```

URL na nuvem (Azure Functions): `https://miaudota-func-agb9gabrehe6aye2.southafricanorth-01.azurewebsites.net/api/indicador-adocao` (exige a chave da função no cabeçalho `x-functions-key` ou em `?code=`).

## Testes

```bash
npm test
```

## Integrantes

- Sofhia Chromiec
- Fernanda Giacobbo
- Júlia Melo
- Pedro Serafim
