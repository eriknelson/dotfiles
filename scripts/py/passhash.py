import bcrypt

password = input('Enter password:')
salt = bcrypt.gensalt()
hashed_passwd = bcrypt.hashpw(password.encode(), salt)
print(hashed_passwd.decode())
