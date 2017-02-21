from flask import Flask, request, render_template
from fib import fib

app = Flask(__name__)


@app.route('/')
def hello_world():
    n = int(request.args.get('n', 0))
    return render_template('hello.html', result=fib(n))


application = app
