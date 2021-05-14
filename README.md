# Laboratory_barnaul2021

### Авторизация/Регистрация
```text
Авторизация пользователя
-> POST /api/user/login
Body: 
{
  'login': str,
  'password': str
}

response:
{
  'id_session': str
}
```
```text
Регистрация пользователя 
-> GET /api/user/register
Body: 
{
  'login': str,
  'password': str
}

response:
{
  'id_session': str
}
```

### Пользователи 
```text
Получение профиля текущего пользователя
-> GET /api/user/profile
response:
{
  'id_user': int,
  'name': str,
  'picture': str,
  'number': str,
  'date_birthday': date
}
```
```text
Получение конкретного пользователя по его ID
-> GET /api/user/<int::id_user>
response:
{
  'id_user': int,
  'name': str,
  'picture': str,
  'number': str,
  'date_birthday': date
}
```

