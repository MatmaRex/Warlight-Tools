#coding: utf-8
def ask!
	print '> '
	return gets.strip
end

begin
	puts 'Enter the name of file to edit: '
	read = ask!
	read += '.svg' unless read.end_with? '.svg'

	while !File.exist? read
		puts 'No such file! Try again:'
		read = ask!
		read += '.svg' unless read.end_with? '.svg'
	end



	puts 'Enter the name of file to write the result to: '
	write = ask!
	write += '.svg' unless write.end_with? '.svg'

	while File.exist? write
		puts 'This file already exists. Do you want to overwrite it? (Y/N)'
		yesno = ask!.downcase
		overw = yesno == 'y' || yesno == 'yes'
		
		if overw
			break
		else
			puts 'Enter a different filename: '
			write = ask!
			write += '.svg' unless write.end_with? '.svg'
		end
	end



	r = File.open(read){|f| f.read}
	changes = r.gsub!('id="path', 'id="Territory_')
	File.open(write, 'w'){|f| f.write r}

	if changes
		print 'Done. '
	else
		print 'File processed, but no changes were made. '
	end

	puts 'Press Enter to finish.'
	gets
rescue Exception => e
	puts 'Whoops! Something bad happened. '
	puts 'The error message was: '
	puts e.to_s
	puts 'This tool will now exit; you may try running it again.'
	gets
end
