import unittest


class MyTestCase(unittest.TestCase):
    def test_something(self):
        self.assertEqual(False, False)  # add assertion here

    # add new unittest that checks whether 3 equals 4
    def test_something_else(self):
        self.assertEqual(3, 4)


if __name__ == '__main__':
    unittest.main()
