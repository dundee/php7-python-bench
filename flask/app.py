from flask import Flask, request, render_template
app = Flask(__name__)


@app.route('/')
def hello_world():
    n = int(request.args.get('n', 0))
    return render_template('hello.html', result=fib(n))


def fib(n):
    if n < 2:
        return n
    return fib(n - 1) + fib(n - 2)


application = app
