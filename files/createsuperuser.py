from django.core.management import setup_environ
import optparse
import settings

setup_environ(settings)

from django.contrib.auth.models import User

p = optparse.OptionParser()
p.set_usage("""Usage: %prog [options]""")
p.add_option('--username', '-u', dest='username',
             help="""Username for the superuser.""")
p.add_option('--password', '-p', dest='password',
             help="""Password for the superuser.""")

options, arguments = p.parse_args()


u = User(username=options.username)
u.set_password(options.password)
u.is_superuser = True
u.is_staff = True
u.save()