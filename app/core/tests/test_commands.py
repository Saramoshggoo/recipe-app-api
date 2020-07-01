from unittest.mock import patch

from django.core.management import call_command
from django.db.utils import OperationalError
from django.test import TestCase

#make sure we are linked to database then send request
#when database is not available opertationalerror run mishe 
class CommandsTestCase(TestCase):
    # when db is ready 
    def test_wait_for_db_ready(self):
        """Test waiting for db when db is available"""
        #retieve data from database  which is avaliable in jango line below 
        with patch('django.db.utils.ConnectionHandler.__getitem__') as gi:
            gi.return_value = True
            call_command('wait_for_db') #"name manage command "
            self.assertEqual(gi.call_count, 1)

    @patch('time.sleep', return_value=None)
    def test_wait_for_db(self, ts):
        """Test waiting for db"""

        with patch('django.db.utils.ConnectionHandler.__getitem__') as gi:
            gi.side_effect = [OperationalError] * 5 + [True] # first 5 time 
            call_command('wait_for_db')
            self.assertEqual(gi.call_count, 6) # in 6 time goes to be sucessful