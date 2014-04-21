f_read = open("minimized_adjacency_numbers.txt","r")
f = open("fixed_minimized_adjacency_numbers.txt","w")
blogs = dict()

for a in f_read.readlines():
	blogs[a.strip().split(' ')[0]] = len(blogs)+1

f_read.close()
f_read = open("minimized_adjacency_numbers.txt","r")

last_blog = 1
for a in f_read.readlines():
	print_new_line = False
	if a.strip().split(' ')[0] not in blogs:
		blogs[a.strip().split(' ')[0]] = len(blogs)+1
	else:
		last_blog = blogs[a.strip().split(' ')[0]]
	for b in a.strip().split(' '):
		if b in blogs:
			f.write(str(blogs[b])+' ')
		else:
			blogs[b] = len(blogs)+1
			f.write(str(blogs[b])+' ')
	f.write('\n')
while last_blog <= len(blogs):
	f.write(str(last_blog)+' \n')
	last_blog += 1
f.close()