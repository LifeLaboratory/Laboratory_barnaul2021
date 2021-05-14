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
headers:
{
  'session': str
}
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

### Задачи 
```text
Получение задач текущего пользователя
-> GET /api/tasks
headers:
{
  'session': str
}
response:
{
  'id_tasks': int,
  'description': str,
  'status': int,
  'stars': int,
  'picture': str,
  'admin_name': str,
  'date_start': str,
  'date_end': str
}
```
```text
Добавление задания пользователю по его ID
-> POST /api/tasks
headers:
{
  'session': str
}
body: 
{
  'description': str,
  'picture': str,
  'tag': str
}
response:
{
  'id_tasks': int,
  'description': str,
  'status': int,
  'stars': int,
  'picture': str,
  'admin_name': str,
  'date_start': str,
  'date_end': str
}
```
```text
Обновление задания пользователя по его ID
-> PUT /api/tasks
headers:
{
  'session': str
}
body: 
{
  'star': int,
  'status': int
}
response:
{
  'id_tasks': int,
  'description': str,
  'status': int,
  'stars': int,
  'picture': str,
  'admin_name': str,
  'date_start': str,
  'date_end': str
}
```


### Статистика 
```text
Получение статистики по задачам
-> GET /api/statistics
headers:
{
  'session': str
}
response:
{
  'name': str,
  'value': int
}
```


### Статистика 
```text
Получение статистики по задачам
-> GET /api/statistics
headers:
{
  'session': str
}
response:
{
  'name': str,
  'value': int
}
```

```text
Получение статистики по выполненнию задач пользователями 
-> GET /api/statistics/users
headers:
{
  'session': str
}
response:
{
  'name': str,
  'status': str, 
  'value': int
}
```