# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

Documentação da API
(Não é necessário autenticação para acessar os endpoints abaixo)

Endpoint: GET /api/v1/guesthouses
Permite listar todas as pousadas cadastradas e ativas.
Exemplo de Resposta de Sucesso (Status 200):
[
  {
    "brand_name": "Pousada Sulamericana",
    "city": "Recife",
  },
  {
    "brand_name": "Pousada Aconchego",
    "city": "Paulista",
  }
]

Endpoint: GET /api/v1/guesthouses?search='nome da pousada'
Permite filtrar as pousadas cadastradas e ativas pelo nome, por meio do parâmetro 'search'
Exemplo de Resposta de Sucesso (Status 200):
GET /api/v1/guesthouses?search='Sulamericana'
[
  {
    "brand_name": "Pousada Sulamericana",
    "city": "Recife",
  }
]

Endpoint: GET /api/v1/guesthouses/:id
Permite obter detalhes de uma pousada ativa, por meio do parâmetro 'id' da pousada.
Exemplo de Resposta de Sucesso (Status 200):
{
  "brand_name": "Pousada Muro Alto",
  "phone_number": "8134658799",
  "email": "pousadamuroalto@gmail.com",
  "address": "Av. Beira Mar, 45",
  "neighborhood": "Muro Alto",
  "state": "Pernambuco",
  "city": "Ipojuca",
  "postal_code": "54350820",
  "description": "Pousada a beira mar maravilhosa",
  "payment_method": "Dinheiro, pix e cartão",
  "pet_agreement": "sim",
  "usage_policy": "Proibido fumar nas áreas de convivência",
  "check_in": "13:00",
  "check_out": "12:00",
  "average_score": 3.8
}

Endpoint: GET /api/v1/guesthouses/:id/rooms
Permite listar os quartos disponíveis de uma pousada ativa, por meio do parâmetro 'id' da pousada.
Exemplo de Resposta de Sucesso (Status 200):
[
  {
    "name": "Quarto Padrão",
    "description": "Quarto bem ventilado",
    "area": 10,
    "max_guest": 2,
    "default_price": 180
  },
  {
    "name": "Quarto Premium",
    "description": "Quarto maravilhoso",
    "area": 13,
    "max_guest": 4,
    "default_price": 250
  }
]

Endpoint: POST /api/v1/rooms/:id/bookings/check_availability
Permite consultar a disponibilidade de um quarto em certo período, para possivelmente criar uma reserva.
Parâmetros de requisição obrigatórios:
id: identificador único do quarto.
check_in_date: data de entrada desejada. Formato: "YYYY-MM-DD".
check_out_date: data de saída desejada. Formato: "YYYY-MM-DD".
guests_number: Número de hóspedes para a reserva.
Exemplo de Requisição:
{
  "booking": {
    "check_in_date": "2023-12-01",
    "check_out_date": "2023-12-05",
    "guests_number": 2
    "room": 1
  }
}
Exemplo de Resposta de Sucesso (Status 200):
Retorna um JSON contendo o preço total da reserva se o quarto estiver disponível para o período solicitado.
{
  "total_price": 840
}