#!/usr/bin/python
import cfworker
import time, os

worker = cfworker.cfworker()
worker.start()

while True:
	print 'Task server is running'
	time.sleep(10)

worker.stop()
