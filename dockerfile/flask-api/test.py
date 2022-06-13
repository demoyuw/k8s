import unittest
from api import app
import json


class TestLogin(unittest.TestCase):

    def setUp(self):
        app.testing = True
        self.client = app.test_client()
    
    def test_empty_name_password(self):

        response = self.client.post("/dologin", data={})
        resp_json = response.data
        resp_dict = json.loads(resp_json)
        self.assertIn("code", resp_dict)
        code = resp_dict.get("code")
        self.assertEqual(code, 1)

        response = self.client.post("/dologin", data={"name": "admin"})

        resp_json = response.data

        resp_dict = json.loads(resp_json)

        self.assertIn("code", resp_dict)

        code = resp_dict.get("code")
        self.assertEqual(code, 1)

    def test_wrong_name_password(self):
        
        response = self.client.post("/dologin", data={"name": "admin", "password": "xxx"})

        resp_json = response.data

        resp_dict = json.loads(resp_json)

        self.assertIn("code", resp_dict)

        code = resp_dict.get("code")
        self.assertEqual(code, 2)


if __name__ == '__main__':
    unittest.main() 