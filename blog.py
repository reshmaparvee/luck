from flask import Flask, render_template, request,session,redirect
from  flask_sqlalchemy import SQLAlchemy
from werkzeug import secure_filename
from flask_mail import Mail
import json
import os
import math
from datetime import datetime
import pymysql
pymysql.install_as_MySQLdb()



with open('config.json','r') as c:
    params=json.load(c)["params"]
local_server=True



app=Flask(__name__)
app.secret_key='super-secret-key'
app.config['UPLOAD_FOLDER']=params["upload_location"]

app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME= params['gmail-user'],
    MAIL_PASSWORD=params['gmail-password']

)
mail=Mail(app)

if local_server:

    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']
db = SQLAlchemy(app)


class Contact(db.Model):

    '''

    S.NO,Name,Email,Phone,Message,Date
    '''
    SNO = db.Column(db.Integer, primary_key=True)
    Name = db.Column(db.String(80), nullable=False)
    Email = db.Column(db.String(20),  nullable=False)
    Phone = db.Column(db.String(12),  nullable=False)
    Message = db.Column(db.String(120),  nullable=False)
    Date = db.Column(db.String(12),  nullable=True)



class Posts_blog(db.Model):

    '''

    SNO,Title,slug,Content,Date
    '''
    SNO = db.Column(db.Integer, primary_key=True)
    Title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(21),  nullable=False)
    Content = db.Column(db.String(12),  nullable=False)
    tagline = db.Column(db.String(12), nullable=False)
    Date = db.Column(db.String(12),  nullable=True)
    img_file = db.Column(db.String(12), nullable=True)



'''@app.route('/')
def home():
    posts=Posts_blog.query.filter_by().all()
    return render_template("index.html", params=params,posts=posts)'''

@app.route("/")
def home():
    posts = Posts_blog.query.filter_by().all()
    last=math.ceil(len(posts)/int(params['no_of_posts']))
    #[0:int(params['no_of_posts'])]
    page=request.args.get('page')
    if not str(page).isnumeric():
        page=1
    page=int(page)
    posts=posts[(page-1)*int(params['no_of_posts']):(page-1)*int(params['no_of_posts'])+int(params['no_of_posts'])]
    #pagination logic
    #first page
    if page==1:
        prev="#"
        next="/?page="+str(page+1)
    elif page==last:
        prev ="/?page="+str(page-1)
        next ="#"
    else:
        prev ="/?page="+str(page-1)
        next ="/?page="+str(page+1)






    return render_template('index.html', params=params, posts=posts,prev=prev,next=next)


@app.route('/post/<string:post_slug>',methods=["GET"])
def post_route(post_slug):
    post=Posts_blog.query.filter_by(slug=post_slug).first()
    return render_template("post.html", params=params, post=post)


@app.route('/about')
def about():
    return render_template("about.html", params=params)


@app.route('/dashboard',methods=["GET","POST"])
def dashboard():
    if 'user' in session and session['user']==params['admin_user']:
        posts = Posts_blog.query.all()
        return render_template('dashboard.html',params=params,posts=posts)
    if request.method=="POST":
        username=request.form.get('uname')
        userpass=request.form.get('pass')
        if username==params['admin_user'] and userpass==params['admin_password']:
            session['user']=username
            posts = Posts_blog.query.all()
            return render_template('dashboard.html',params=params,posts=posts)


    return render_template("login.html", params=params)



@app.route('/post')
def post():

    return render_template('post.html', params=params,post=post)




@app.route('/edit/<string:SNO>',  methods=["GET","POST"])
def edit(SNO):
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method=="POST":
            box_title=request.form.get("Title")
            tagline = request.form.get("tagline")
            slug = request.form.get("slug")
            Content = request.form.get("Content")
            img_file = request.form.get("img_file")
            Date=datetime.now()
            if SNO=='0':
                post=Posts_blog(Title=box_title,tagline=tagline,slug=slug,Content=Content,img_file=img_file,Date=Date)
                db.session.add(post)
                db.session.commit()
            else:
                post=Posts_blog.query.filter_by(SNO=SNO).first()
                post.Title=box_title
                post.tagline=tagline
                post.slug=slug
                post.Content=Content
                post.img_file=img_file
                post.Date=Date
                db.session.commit()
                return redirect('/edit/'+SNO)
        post = Posts_blog.query.filter_by(SNO=SNO).first()
        return render_template('edit.html',params=params,post=post, SNO=SNO)

@app.route('/uploader',  methods=["GET","POST"])
def uploader():
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method == 'POST':
            f=request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(f.filename)))
            return "Uploaded Successfully"


@app.route('/logout')
def logout():
    session.pop('user')
    return redirect('/dashboard')


@app.route('/delete/<string:SNO>',  methods=["GET","POST"])
def delete(SNO):
    if 'user' in session and session['user'] == params['admin_user']:
        post=Posts_blog.query.filter_by(SNO=SNO).first()
        db.session.delete(post)
        db.session.commit()

    return redirect('/dashboard')


@app.route('/contact',  methods=["GET","POST"])
def contact():
    if request.method=='POST':
        ''' entry to database
        '''
        name=request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        '''

            S.NO,Name,Email,Phone,Message,Date
            '''
        entry=Contact(Name=name,Email=email,Phone=phone,Message=message, Date=datetime.now())
        db.session.add(entry)
        db.session.commit()
        mail.send_message('New Message from ' + email,
                          sender=email,
                          recipients=[params['gmail-user']],
                          body=message + "\n" + phone

        )



    return render_template("contact.html", params=params)

app.run(debug=True)

