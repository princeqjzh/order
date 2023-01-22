# -*- coding:UTF-8 -*-
import unittest
import HTMLReport


class TestReport(unittest.TestCase):
    def setUp(self):
        print("start")

    def tearDown(self):
        print("end")
        
    def test_case01(self):
        self.assertEquals("123","123")

    def test_case02(self):
        self.assertEquals("123","3")

    def test_case03(self):
        self.assertEquals("aaa","aaa")

    @unittest.skip("skip")
    def test_case04(self):
        self.assertEquals("abc","acb")


if  __name__ == "__main__":
    suite = unittest.TestSuite()
    suite.addTest(TestReport("test_case01"))
    suite.addTest(TestReport("test_case02"))
    suite.addTest(TestReport("test_case03"))
    suite.addTest(TestReport("test_case04"))
    runner = HTMLReport.TestRunner(
        report_file_name='index',
        output_path='report',
        title='testReport',
        description='no',
        thread_count=1,
        thread_start_wait=3,
        sequential_execution=False,
        lang='cn'
    )
    runner.run(suite)