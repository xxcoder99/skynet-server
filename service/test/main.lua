local skynet = require "skynet"
local RedisMQ = require "redis_mq"
local share_memory = require "share_memory"


local function testMQ(...)
	print("testMQ message=", ...)
end

skynet.start(function()
	local conf = {
		host = "127.0.0.1" ,
		port = 6379 ,
		db = 0
	}
	local mq = RedisMQ(conf, testMQ)

	mq:publish("auth.login", "hello")
	mq:start_watching()

	-- mq:subscribe("auth.login")
	-- for i=1, 10 do
	-- 	if i == 1 then
	-- 		mq:subscribe("auth.test")
	-- 	else
	-- 		mq:publish("auth.test", "test+"..i)
	-- 	end
		
	-- 	mq:publish("auth.login", "hello+"..i)
	-- 	mq:publish("auth.login", "world+"..i)
	-- 	print("publish i=", i)
	-- 	skynet.sleep(1*100)
	-- end

	skynet.newservice("test_share_memory1")
	skynet.newservice("test_share_memory")
	

 	skynet.error("server is start")

end)