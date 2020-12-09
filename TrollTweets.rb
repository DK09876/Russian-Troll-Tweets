require 'csv'
require 'open-uri'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

def count_troll_types(filename)

  if filename.start_with? 'http'
    # read a whole 90 MB file; this will be SLOW!!!!
    csv_text = open(filename)
  else
    # read the text of the whole file-
    csv_text = File.read(filename)
  end
  # now parse the file, assuming it has a header row at the top
  csv = CSV.parse(csv_text, :headers => true)

  # hash from categories to the number of tweets in category
  # keys are categories (string), values are count (integers)
  categories = Hash.new

  # go through each row of the csv file
  csv.each do |row|
    # convert the row to a hash
    # the keys of the hash will be the headers from the csv file
    hash = row.to_hash
    # this is a trick to make sure that this key exists in a hash
    # so that the next line which adds 1 will never fail
    if !categories.include? hash['account_category']
      categories[hash['account_category']] = 0
    end
    # This cannot fail because if the key hadn't existed,
    # then the previous if will have created it
    categories[hash['account_category']] += 1
  end
  # now print the key/value pairs
  categories.each do |key, value|
    puts "#{key} occurs #{value} times"
  end
  puts
end
#################################################################






##############################################################
def count_common_date(filename)

  if filename.start_with? 'http'
    # read a whole 90 MB file; this will be SLOW!!!!
    csv_text = open(filename)
  else
    # read the text of the whole file
    csv_text = File.read(filename)
  end
  # now parse the file, assuming it has a header row at the top
  csv = CSV.parse(csv_text, :headers => true)
  count = Hash.new
  # go through each row of the csv file
  csv.each do |row|
    # convert the row to a hash
    # the keys of the hash will be the headers from the csv file
    hash = row.to_hash
    #trim the date and time
    trim=hash['publish_date'].split
    # this is a trick to make sure that this key exists in a hash
    # so that the next line which adds 1 will never fail
    if !count.include? trim[0]
      count[trim[0]] = 0
    end
    count[trim[0]] += 1
  end
  #print the top 10 most common dates
  for i in 1..10
    temp=count.max_by{|k,v| v}
    #from stackoverflow
    puts "Date: #{temp[0]} had #{temp[1]} tweets."
    #delete the max value so the second max value becomes the max in next loop
    count.delete(temp[0])
  end
  puts
end
##################################################################


##############################################################
def count_common_hour(filename)

  if filename.start_with? 'http'
    # read a whole 90 MB file; this will be SLOW!!!!
    csv_text = open(filename)
  else
    # read the text of the whole file
    csv_text = File.read(filename)
  end
  # now parse the file, assuming it has a header row at the top
  csv = CSV.parse(csv_text, :headers => true)
  count = Hash.new
  # go through each row of the csv file
  csv.each do |row|
    # convert the row to a hash
    # the keys of the hash will be the headers from the csv file
    hash = row.to_hash
    #trim the hour and mins
    trim=hash['publish_date'].split
    #trim the time into just hours
    hours=trim[1].split(':')
    # this is a trick to make sure that this key exists in a hash
    # so that the next line which adds 1 will never fail
    if !count.include? hours[0]
      count[hours[0]] = 0
    end
    count[hours[0]] += 1
  end


  #print the top 10 most common dates
    temp=count.max_by{|k,v| v}
    #from stackoverflow
    puts "hour #{temp[0]} had the most tweets at #{temp[1]}."
  puts
end
##################################################################



##############################################################
def count_common_word(filename)
  if filename.start_with? 'http'
    # read a whole 90 MB file; this will be SLOW!!!!
    csv_text = open(filename)
  else
    # read the text of the whole file
    csv_text = File.read(filename)
  end
  # now parse the file, assuming it has a header row at the top
  csv = CSV.parse(csv_text, :headers => true)
  count = Hash.new
  # go through each row of the csv file
  csv.each do |row|
    # convert the row to a hash
    # the keys of the hash will be the headers from the csv file
    hash = row.to_hash
    #split into words
    words=hash['content'].split
    # this is a trick to make sure that this key exists in a hash
    # so that the next line which adds 1 will never fail
    #loop through each word
    words.each do |word|
      if !count.include? word
        count[word] = 0
      end
      count[word] += 1
    end
  end
  #print the most common word
  count.each do |k,v|
    puts " '#{k}' is most common which occurs #{v} times."  if v==count.values.max
  end
  puts
end
##################################################################

##############################################################
def find_most_common_langs(filename)

  if filename.start_with? 'http'
    # read a whole 90 MB file; this will be SLOW!!!!
    csv_text = open(filename)
  else
    # read the text of the whole file
    csv_text = File.read(filename)
  end
  # now parse the file, assuming it has a header row at the top
  csv = CSV.parse(csv_text, :headers => true)
  count = Hash.new
  # go through each row of the csv file
  csv.each do |row|
    # convert the row to a hash
    # the keys of the hash will be the headers from the csv file
    hash = row.to_hash
    language=hash['language']
    # this is a trick to make sure that this key exists in a hash
    # so that the next line which adds 1 will never fail
    if !count.include? language
      count[language] = 0
    end
    count[language] += 1
  end
    #loop through count to find the most common language
    for i in 1..3 do
    temp=count.max_by{|k,v| v}
    #same thing as top 10 dates
    puts "#{temp[0]} is the #{i} most common language used #{temp[1]} times."
    count.delete(temp[0])
    end
  puts
end
##################################################################




##############################################################
def common_word_among_account_type(filename)
  if filename.start_with? 'http'
    # read a whole 90 MB file; this will be SLOW!!!!
    csv_text = open(filename)
  else
    # read the text of the whole file
    csv_text = File.read(filename)
  end
  # now parse the file, assuming it has a header row at the top
  csv = CSV.parse(csv_text, :headers => true)

  # hash from categories to the number of tweets in category
  # keys are categories (string), values are count (integers)
  categories = Hash.new

  # go through each row of the csv file
  csv.each do |row|
    # convert the row to a hash
    # the keys of the hash will be the headers from the csv file
    hash = row.to_hash
    # this is a trick to make sure that this key exists in a hash
    # so that the next line which adds 1 will never fail
    if !categories.include? hash['account_category']
      categories[hash['account_category']] = 0
    end
    # This cannot fail because if the key hadn't existed,
    # then the previous if will have created it
    categories[hash['account_category']] += 1
  end
  mostcalledwords=Hash.new
  #an array of commmon words oin english (https://gist.github.com/gravitymonkey/2406023)
 common=["the","of","and","a","to","in","is","you","that","it","he","was","for","on","are","as","with","his","they","I","at","be","this","have","from","or","one","had","by","word","but","not","what","all","were","we","when","your","can","said","there","use","an","each","which","she","do","how","their","if","will","up","other","about","out","many","then","them","these","so","some","her","would","make","like","him","into","time","has","look","two","more","write","go","see","number","no","way","could","people","my","than","first","water","been","call","who","oil","its","now","find","long","down","day","did","get","come","made","may","part","The","I'm","me","\\|","-","me","RT","That","https://t.co/1KPXto2HfW"]
 #sort by descending order so i can get the most common types at first
  categories=categories.sort_by{|k,v| v}.reverse
  categories.each do |k,v|
    csv.each do |row|
      hash=row.to_hash
      if hash['account_category']==k
        words=hash['content'].split
        #loop through each word
        words.each do |word|
          #removing the gibberish stuff after running many times with the common words and adjusting the values in the common array
          if common.include? word
              next
          end
          if !mostcalledwords.include? word
            mostcalledwords[word] = 0
          end
          mostcalledwords[word] += 1
        end
      end
    end
    mostcalledwords=mostcalledwords.sort_by{|k,v| v}.reverse
    puts "#{mostcalledwords.first[0]} is the most commmon word said by #{k} #{mostcalledwords.first[1]} times"
    mostcalledwords=Hash.new
  end
end



##################################################################

#################################################################
def most_followed_accounts_language(filename)
  if filename.start_with? 'http'
    # read a whole 90 MB file; this will be SLOW!!!!
    csv_text = open(filename)
  else
    # read the text of the whole file
    csv_text = File.read(filename)
  end
  # now parse the file, assuming it has a header row at the top
  csv = CSV.parse(csv_text, :headers => true)
  count = Hash.new
  language=Hash.new
  # go through each row of the csv file
  csv.each do |row|
    # convert the row to a hash
    # the keys of the hash will be the headers from the csv file
    hash = row.to_hash
    if !count.include? hash['author']
      count[hash['author']]=hash['followers'].to_i
      language[hash['author']]=hash['language']
    else
      next
    end
  end
  #find the 3 greatest value of followers
  for i in 1..5
  temp=count.max_by{|k,v| v}
  puts "#{temp[0]} is the #{i} most followed author using #{language[temp[0]]} with #{temp[1]} followers."
  count.delete(temp[0])
  end
end



##################################################################



#these are for only 1000 tweets
#count_troll_types('test-tweets.csv')
#count_common_date('test-tweets.csv')
#count_common_hour('test-tweets.csv')
#count_common_word('test-tweets.csv')
########################################
#these are for about 250k tweets
#find_most_common_langs('https://raw.githubusercontent.com/fivethirtyeight/russian-troll-tweets/master/IRAhandle_tweets_1.csv')
common_word_among_account_type('https://raw.githubusercontent.com/fivethirtyeight/russian-troll-tweets/master/IRAhandle_tweets_1.csv')
#most_followed_accounts_language('https://raw.githubusercontent.com/fivethirtyeight/russian-troll-tweets/master/IRAhandle_tweets_1.csv')
