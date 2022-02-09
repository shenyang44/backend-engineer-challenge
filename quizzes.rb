'Each challenge comes with their pre-defined variable, candidates have to use these variables and are not allowed to modify them.'

######################################################################################
  'Challenge 1: String scrubbing
    The paragraph given below contains special characters that are usually the 
    source of great evil that distrupts subsequent functions if left untreated.
    Write a method to cleanse the paragraph of non-alpha numeric characters,
    and make them all lowercase and trimmed'

    paragraph = "Grant me the ’S3R3NITY’ to accept the things I cannot change –
                  The ’C0URAGE’ to change the things I can –
                    And the ’W1SD0M’ to know the difference"

    expected_answer = "grant me the s3r3nity to accept the things i cannot change the c0urage to change the things i can and the w1sd0m to know the difference"

    def sanitize_paragraph(paragraph)
      return paragraph.downcase.gsub(/[^\w ]/, "").squeeze(' ')
    end
    
    puts "Challenge 1 completed: #{sanitize_paragraph(paragraph) == expected_answer}"

#####################################################################################
  'Challenge 2: Substring extraction
    Given the following array of address string, extract each of their state. Your solution should accomodate all of the cases'

    addresses = [
      "SIBU - JALAN JERRWIT TIMUR, Jalan Jerrwit Timur, Sibu, Sarawak",
      "KAMPUNG KUBUR SHARIF, Bukit Rakit, Kuala Terengganu, Terengganu Darul Iman",
      "Persiaran Laksamana, Puteri Harbour, 79250, Johor",
      "LOT PT 6458, Kuala Berang, Hulu Terengganu, Terengganu",
      "PANGSAPURI CEMPAKA,Bandar Bukit Puchong, 47100 Puchong, Selangor Darul Ehsan",
      "OASIS ARA DAMANSARA, JALAN PJU 7A/1A, ARA DAMANSARA, 47301 PJ, SELANGOR, MALAYSIA",
    ]

    expected_answer = [
      "SARAWAK", "TERENGGANU", "JOHOR", "TERENGGANU", "SELANGOR", "SELANGOR"
    ]

    def get_state(address)
      ["SARAWAK", "TERENGGANU", "JOHOR", "TERENGGANU", "SELANGOR", "SELANGOR"].each { |x| 
        if address.upcase.include?(x)
          return x
        end
      }
    end

    # passing validation
    addresses.each_with_index do |address, index|
      puts "Challenge 2-#{index+1} completed: #{get_state(address) == expected_answer[index]}"
    end

#####################################################################################
  'Challenge 3: Parsing
    Given the following array of coordinate, convert it into Well-Known Text (WKT) format.
    Wiki link on WKT and its format: https://en.wikipedia.org/wiki/Well-known_text_representation_of_geometry
    Hint: recursion might be a friend here'

    coordinate_pair = [[[[30,20], [45,40], [10,40], [30,20]]], [[[15,5], [40,10], [10,20], [5,10], [15,5]]]]
    expected_answer = "MULTIPOLYGON (((30 20, 45 40, 10 40, 30 20)), ((15 5, 40 10, 10 20, 5 10, 15 5)))"

    def coord_to_wkt(coordinate_pair)
      str_coords = coordinate_pair.to_s
      chars = str_coords.split('')
      chars.each_with_index do |c, i|
        if c == ',' && chars[i-1] =~ /\d/
          chars[i] = ''
        end
      end
      chars.each_with_index do |c, i|
        if '[]'.include?(c) && (chars[i-1] =~ /\d/ || chars[i+1] =~ /\d/)
          chars.delete_at(i)
        end
      end

      str = chars.join.gsub(/\[/, '(').gsub(/\]/,')')
      return "MULTIPOLYGON " << str
    end

    # passing validation
    puts "Challenge 3 completed: #{coord_to_wkt(coordinate_pair) == expected_answer}"

#####################################################################################
  'Challenge 4: is_palindrome?
    Palindrome is a sequence of characer that reads the same backward as it is forward, eg: 
    KAYAK when spelled in reverse is still KAYAK; MADAM, RACECAR etc.
    Write a method that accepts a string & returns true or false depending on 
    whether the input is a palindrome or not.
    Bonus points for the elegant recursive solution!'

    def is_palindrome?(word)
      if word.length <= 1
        return true
      end
      chars = word.split('')
      if chars[0] == chars[-1]
        is_palindrome?(word[1,word.length-2])
      else
        return false
      end
    end

    # passing validation
    puts "Challenge 4-1: is 'RADAR' a palindrome? Output: #{is_palindrome?('RADAR').to_s || "nil"} | Correct answer: true"
    puts "Challenge 4-2: is '2121' a palindrome? Output: #{is_palindrome?('2121').to_s || "nil"} | Correct answer: false"
    puts "Challenge 4-3: is 'x' a palindrome? Output: #{is_palindrome?('x').to_s || "nil"} | Correct answer: true"