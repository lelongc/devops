# Python Projects with Docker

Tổng hợp các loại project Python phổ biến với Dockerfile tương ứng.

## 1. Basic Python Application

### requirements.txt

```
# No dependencies for basic app
```

### app.py

```python
#!/usr/bin/env python3
print("Hello World from Python!")

if __name__ == "__main__":
    print("Basic Python application is running...")
```

### Dockerfile

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["python", "app.py"]
```

## 2. Flask Web Application

### requirements.txt

```
Flask==2.3.3
Werkzeug==2.3.7
```

### app.py

```python
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello World from Flask!'

@app.route('/api/health')
def health_check():
    return jsonify({'status': 'healthy', 'message': 'Flask app is running'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)
```

### Dockerfile

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "app.py"]
```

## 3. Django Web Application

### requirements.txt

```
Django==4.2.7
psycopg2-binary==2.9.7
gunicorn==21.2.0
```

### myproject/settings.py

```python
import os
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

SECRET_KEY = os.environ.get('SECRET_KEY', 'your-secret-key-here')
DEBUG = os.environ.get('DEBUG', 'False').lower() == 'true'
ALLOWED_HOSTS = ['*']

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'myapp',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'myproject.urls'
WSGI_APPLICATION = 'myproject.wsgi.application'

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}
```

### myapp/views.py

```python
from django.http import HttpResponse
from django.shortcuts import render

def index(request):
    return HttpResponse("Hello World from Django!")
```

### manage.py

```python
#!/usr/bin/env python
import os
import sys

if __name__ == '__main__':
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'myproject.settings')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)
```

### Dockerfile

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
RUN python manage.py collectstatic --noinput
EXPOSE 8000
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myproject.wsgi:application"]
```

## 4. FastAPI Application

### requirements.txt

```
fastapi==0.104.1
uvicorn[standard]==0.24.0
pydantic==2.5.0
```

### main.py

```python
from fastapi import FastAPI
from pydantic import BaseModel
from typing import Dict

app = FastAPI(title="Hello World API", version="1.0.0")

class Message(BaseModel):
    message: str

@app.get("/")
async def root():
    return {"message": "Hello World from FastAPI!"}

@app.get("/api/health")
async def health_check():
    return {"status": "healthy", "framework": "FastAPI"}

@app.post("/api/echo")
async def echo_message(message: Message):
    return {"echo": f"You said: {message.message}"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
```

### Dockerfile

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

## 5. Streamlit Data App

### requirements.txt

```
streamlit==1.28.1
pandas==2.1.3
numpy==1.25.2
plotly==5.17.0
```

### app.py

```python
import streamlit as st
import pandas as pd
import numpy as np
import plotly.express as px

st.title("Hello World from Streamlit!")

st.write("Welcome to this simple Streamlit app")

# Create sample data
data = {
    'x': np.random.randn(100),
    'y': np.random.randn(100),
    'category': np.random.choice(['A', 'B', 'C'], 100)
}
df = pd.DataFrame(data)

st.subheader("Sample Data")
st.dataframe(df.head())

st.subheader("Interactive Plot")
fig = px.scatter(df, x='x', y='y', color='category', title="Sample Scatter Plot")
st.plotly_chart(fig)

if st.button("Say Hello"):
    st.success("Hello World! 🎉")
```

### Dockerfile

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8501
HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
```

## 6. Jupyter Notebook Server

### requirements.txt

```
jupyter==1.0.0
notebook==7.0.6
matplotlib==3.8.2
seaborn==0.13.0
scikit-learn==1.3.2
```

### notebooks/hello_world.ipynb

```json
{
  "cells": [
    {
      "cell_type": "markdown",
      "metadata": {},
      "source": ["# Hello World from Jupyter Notebook"]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {},
      "source": [
        "print(\"Hello World from Jupyter!\")\n",
        "import matplotlib.pyplot as plt\n",
        "import numpy as np\n",
        "\n",
        "x = np.linspace(0, 10, 100)\n",
        "y = np.sin(x)\n",
        "\n",
        "plt.figure(figsize=(10, 6))\n",
        "plt.plot(x, y)\n",
        "plt.title('Hello World - Sine Wave')\n",
        "plt.show()"
      ]
    }
  ],
  "metadata": {
    "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
    }
  },
  "nbformat": 4,
  "nbformat_minor": 4
}
```

### Dockerfile

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8888
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
```

## 7. REST API with Flask-RESTful

### requirements.txt

```
Flask==2.3.3
Flask-RESTful==0.3.10
Flask-SQLAlchemy==3.1.1
```

### app.py

```python
from flask import Flask
from flask_restful import Api, Resource, reqparse
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///hello.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
api = Api(app)

class Message(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    content = db.Column(db.String(200), nullable=False)

class HelloWorld(Resource):
    def get(self):
        return {'message': 'Hello World from Flask-RESTful!'}

class MessageAPI(Resource):
    def get(self):
        messages = Message.query.all()
        return {'messages': [{'id': m.id, 'content': m.content} for m in messages]}

    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('content', required=True)
        args = parser.parse_args()

        message = Message(content=args['content'])
        db.session.add(message)
        db.session.commit()

        return {'message': 'Created successfully', 'id': message.id}, 201

api.add_resource(HelloWorld, '/')
api.add_resource(MessageAPI, '/api/messages')

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
        # Add sample data
        if not Message.query.first():
            sample = Message(content="Hello World from Database!")
            db.session.add(sample)
            db.session.commit()

    app.run(host='0.0.0.0', port=5000, debug=False)
```

### Dockerfile

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "app.py"]
```

## 8. Machine Learning API with scikit-learn

### requirements.txt

```
Flask==2.3.3
scikit-learn==1.3.2
pandas==2.1.3
numpy==1.25.2
joblib==1.3.2
```

### app.py

```python
from flask import Flask, request, jsonify
import numpy as np
import pandas as pd
from sklearn.datasets import make_classification
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
import joblib
import os

app = Flask(__name__)

# Train a simple model if not exists
MODEL_PATH = 'model.joblib'

def train_model():
    X, y = make_classification(n_samples=1000, n_features=20, n_informative=10, random_state=42)
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    model = RandomForestClassifier(n_estimators=100, random_state=42)
    model.fit(X_train, y_train)

    joblib.dump(model, MODEL_PATH)
    return model

# Load or train model
if os.path.exists(MODEL_PATH):
    model = joblib.load(MODEL_PATH)
else:
    model = train_model()

@app.route('/')
def hello():
    return jsonify({'message': 'Hello World from ML API!'})

@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.get_json()
        features = np.array(data['features']).reshape(1, -1)
        prediction = model.predict(features)[0]
        probability = model.predict_proba(features)[0].max()

        return jsonify({
            'prediction': int(prediction),
            'probability': float(probability),
            'message': 'Prediction successful!'
        })
    except Exception as e:
        return jsonify({'error': str(e)}), 400

@app.route('/health')
def health():
    return jsonify({'status': 'healthy', 'model_loaded': MODEL_PATH in os.listdir('.')})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)
```

### Dockerfile

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "app.py"]
```

## 9. Celery Worker with Redis

### requirements.txt

```
celery[redis]==5.3.4
redis==5.0.1
Flask==2.3.3
```

### tasks.py

```python
from celery import Celery
import time

app = Celery('tasks', broker='redis://redis:6379/0')

@app.task
def hello_world_task(name='World'):
    time.sleep(2)  # Simulate work
    return f'Hello {name} from Celery!'

@app.task
def add_numbers(x, y):
    time.sleep(1)
    return x + y
```

### flask_app.py

```python
from flask import Flask, jsonify, request
from tasks import hello_world_task, add_numbers

app = Flask(__name__)

@app.route('/')
def index():
    return jsonify({'message': 'Hello World from Flask + Celery!'})

@app.route('/task/hello')
def start_hello_task():
    name = request.args.get('name', 'World')
    task = hello_world_task.delay(name)
    return jsonify({'task_id': task.id, 'status': 'started'})

@app.route('/task/add')
def start_add_task():
    x = int(request.args.get('x', 0))
    y = int(request.args.get('y', 0))
    task = add_numbers.delay(x, y)
    return jsonify({'task_id': task.id, 'status': 'started'})

@app.route('/task/<task_id>')
def get_task_status(task_id):
    task = hello_world_task.AsyncResult(task_id)
    return jsonify({'task_id': task_id, 'status': task.status, 'result': task.result})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)
```

### Dockerfile (Flask App)

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "flask_app.py"]
```

### Dockerfile.worker (Celery Worker)

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["celery", "-A", "tasks", "worker", "--loglevel=info"]
```

## 10. GraphQL API with Graphene

### requirements.txt

```
graphene==3.3
Flask==2.3.3
Flask-GraphQL==2.0.1
```

### app.py

```python
from flask import Flask
from flask_graphql import GraphQLView
import graphene

class Message(graphene.ObjectType):
    id = graphene.Int()
    content = graphene.String()

class Query(graphene.ObjectType):
    hello = graphene.String(name=graphene.String(default_value="World"))
    messages = graphene.List(Message)

    def resolve_hello(self, info, name):
        return f'Hello {name} from GraphQL!'

    def resolve_messages(self, info):
        return [
            Message(id=1, content="Hello World from GraphQL!"),
            Message(id=2, content="This is a sample message")
        ]

class CreateMessage(graphene.Mutation):
    class Arguments:
        content = graphene.String(required=True)

    message = graphene.Field(Message)

    def mutate(self, info, content):
        message = Message(id=999, content=content)
        return CreateMessage(message=message)

class Mutation(graphene.ObjectType):
    create_message = CreateMessage.Field()

schema = graphene.Schema(query=Query, mutation=Mutation)

app = Flask(__name__)
app.add_url_rule('/graphql', view_func=GraphQLView.as_view('graphql', schema=schema, graphiql=True))

@app.route('/')
def index():
    return 'Hello World! Visit /graphql for GraphQL interface'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)
```

### Dockerfile

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python", "app.py"]
```

## 11. Discord Bot

### requirements.txt

```
discord.py==2.3.2
python-dotenv==1.0.0
```

### bot.py

```python
import discord
from discord.ext import commands
import os
from dotenv import load_dotenv

load_dotenv()

intents = discord.Intents.default()
intents.message_content = True

bot = commands.Bot(command_prefix='!', intents=intents)

@bot.event
async def on_ready():
    print(f'{bot.user} has connected to Discord!')
    print('Hello World from Discord Bot!')

@bot.command(name='hello')
async def hello_command(ctx):
    await ctx.send('Hello World from Discord Bot! 🤖')

@bot.command(name='ping')
async def ping_command(ctx):
    latency = round(bot.latency * 1000)
    await ctx.send(f'Pong! Latency: {latency}ms')

@bot.event
async def on_message(message):
    if message.author == bot.user:
        return

    if 'hello' in message.content.lower():
        await message.channel.send('Hello World! 👋')

    await bot.process_commands(message)

if __name__ == '__main__':
    token = os.getenv('DISCORD_TOKEN', 'your-bot-token-here')
    bot.run(token)
```

### .env

```
DISCORD_TOKEN=your-discord-bot-token-here
```

### Dockerfile

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["python", "bot.py"]
```

## 12. Data Processing with Pandas

### requirements.txt

```
pandas==2.1.3
numpy==1.25.2
requests==2.31.0
schedule==1.2.0
```

### processor.py

```python
import pandas as pd
import numpy as np
import requests
import schedule
import time
from datetime import datetime

def process_data():
    print("Hello World from Data Processor!")

    # Create sample data
    data = {
        'timestamp': pd.date_range('2024-01-01', periods=100, freq='H'),
        'value': np.random.randn(100),
        'category': np.random.choice(['A', 'B', 'C'], 100)
    }

    df = pd.DataFrame(data)

    # Process data
    summary = df.groupby('category')['value'].agg(['mean', 'std', 'count'])
    print("Data processing completed:")
    print(summary)

    # Save results
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    output_file = f'processed_data_{timestamp}.csv'
    summary.to_csv(output_file)
    print(f"Results saved to {output_file}")

def main():
    print("Starting data processing service...")

    # Run immediately
    process_data()

    # Schedule to run every hour
    schedule.every().hour.do(process_data)

    while True:
        schedule.run_pending()
        time.sleep(60)

if __name__ == '__main__':
    main()
```

### Dockerfile

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["python", "processor.py"]
```

## Docker Compose Examples

### Flask + Redis + PostgreSQL

```yaml
version: "3.8"
services:
  web:
    build: ./flask-app
    ports:
      - "5000:5000"
    environment:
      - DATABASE_URL=postgresql://user:password@db:5432/myapp
      - REDIS_URL=redis://redis:6379/0
    depends_on:
      - db
      - redis

  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: redis:alpine

volumes:
  postgres_data:
```

### FastAPI + Celery + Redis

```yaml
version: "3.8"
services:
  api:
    build: ./fastapi-app
    ports:
      - "8000:8000"
    depends_on:
      - redis

  worker:
    build:
      context: ./fastapi-app
      dockerfile: Dockerfile.worker
    depends_on:
      - redis

  redis:
    image: redis:alpine
    ports:
      - "6379:6379"

  flower:
    image: mher/flower:0.9.7
    command: flower --broker=redis://redis:6379/0 --port=5555
    ports:
      - "5555:5555"
    depends_on:
      - redis
```

### ML Pipeline

```yaml
version: "3.8"
services:
  ml-api:
    build: ./ml-app
    ports:
      - "5000:5000"
    volumes:
      - ./models:/app/models

  data-processor:
    build: ./data-processor
    volumes:
      - ./data:/app/data
    environment:
      - SCHEDULE_INTERVAL=3600

  jupyter:
    build: ./jupyter-app
    ports:
      - "8888:8888"
    volumes:
      - ./notebooks:/app/notebooks
      - ./data:/app/data
```

## Production Optimizations

### Multi-stage Dockerfile

```dockerfile
# Build stage
FROM python:3.11-slim as builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Production stage
FROM python:3.11-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY . .
ENV PATH=/root/.local/bin:$PATH
USER 1000
CMD ["python", "app.py"]
```

### .dockerignore

```
__pycache__
*.pyc
*.pyo
*.pyd
.Python
env
pip-log.txt
pip-delete-this-directory.txt
.tox
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.log
.git
.mypy_cache
.pytest_cache
.hypothesis
.venv
.env
```

### Health Check Example

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 5000
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:5000/health || exit 1
CMD ["python", "app.py"]
```

Tất cả các project Python trên đều có thể build và chạy với Docker. Mỗi project đại diện cho một pattern phổ biến trong Python development, từ web frameworks đến machine learning và data processing.
