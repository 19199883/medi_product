1.加密脚本文件：
	tar -czvf - -C ./ [要加密的文件] | openssl des3 -salt -k 617999 -out [加密后的文件]
2. 解密
	openssl des3 -d -k 617999 -salt -in %s.txt | tar xzf - 
