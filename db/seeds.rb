
########################
# Create courses
########################
vision_course = Course.create(
  :course_icon => File.open("#{Rails.root}/app/assets/images/courses/vision.png"),
  :intro_screenshot => File.open("#{Rails.root}/app/assets/images/courses/screenshots/vision.png"),
  :title => "Vision",
  :start_date => "2013-09-30 00:00:00",
  :end_date => "2013-10-07 00:00:00",
  :intro_vimeo => '73509527',
  :badge_vimeo => '',
  :length => 12,
  :description => "All brilliant entrepreneurs need it.  A vision leads to a plan that drives you, your company, and your employees. Chase the vision not the valuation and investors will believe you. Learn how to recognize opportunities, be passionate about your vision and be able to sell your vision. What's your vision of what the world will look like in the future?")
creativity_course = Course.create(
  :course_icon => File.open("#{Rails.root}/app/assets/images/courses/creativity.png"),
  :intro_screenshot => File.open("#{Rails.root}/app/assets/images/courses/screenshots/creativity.png"),
  :title => "Creativity",
  :start_date => "2013-10-08 00:00:00",
  :end_date => "2013-10-13 00:00:00",
  :intro_vimeo => '73509938',
  :badge_vimeo => '73507454',
  :length => 15,
  :description => "Creativity and vision lead to radical change and innovation.  Learn to see the world differently, change the rules of every game, expose yourself to something and someone new every day.  Creativity solves seemingly impossible challenges. Once you realize anything is possible, and are willing to try anything, your idea will take off.")
speed_course = Course.create(
  :course_icon => File.open("#{Rails.root}/app/assets/images/courses/speedstrength.png"),
  :intro_screenshot => File.open("#{Rails.root}/app/assets/images/courses/screenshots/speed.png"),
  :title => "Speed & Strength",
  :start_date => "2013-10-14 00:00:00",
  :end_date => "2013-10-20 00:00:00",
  :intro_vimeo => '73541312',
  :badge_vimeo => '73507189',
  :length => 13,
  :description => "Entrepreneurism is one of the hardest things to do.  Once you have a vision, how will you get ahead of competitors with limited resources? Know your strengths and don't be afraid to experiment. Spee and your unique strengths are your greatest weapons.")
evangelism_course = Course.create(
  :course_icon => File.open("#{Rails.root}/app/assets/images/courses/evangelism.png"),
  :intro_screenshot => File.open("#{Rails.root}/app/assets/images/courses/screenshots/evangelism.png"),
  :title => "Evangelism",
  :start_date => "2013-10-21 00:00:00",
  :end_date => "2013-10-28 00:00:00",
  :intro_vimeo => '73540634',
  :badge_vimeo => '73507455',
  :length => 15,
  :description => "Along your journey in creating a business, you will need to become great at selling it. You will have to convince people that this is something they NEED. Be an expert and your biggest advocate.  But don't just sell it yourself, get others to talk about your business.  With the power of viral marketing, your idea can spread like wildfire. Press, whether it's good or bad, is press. Learn how to handle both situations by being genuine and honest.")
power_course = Course.create(
  :course_icon => File.open("#{Rails.root}/app/assets/images/courses/power.png"),
  :intro_screenshot => File.open("#{Rails.root}/app/assets/images/courses/screenshots/power.png"),
  :title => "Power",
  :start_date => "2013-10-29 00:00:00",
  :end_date => "2013-11-04 00:00:00",
  :intro_vimeo => '73540635',
  :badge_vimeo => '73507189',
  :length => 15,
  :description => "Heroes come in different shapes and sizes, but they all have unique powers. They have knowledge, resources, talents, and know how to make the most of these things. Power is influence. Learn how to master the system and what works best for your business as it grows. Continue building and refining your arsenal of powers.")
survival_course = Course.create(
  :course_icon => File.open("#{Rails.root}/app/assets/images/courses/survival.png"),
  :intro_screenshot => File.open("#{Rails.root}/app/assets/images/courses/screenshots/survival.png"),
  :title => "Survival",
  :start_date => "2013-11-05 00:00:00",
  :end_date => "2013-11-12 00:00:00",
  :intro_vimeo => '73540636',
  :badge_vimeo => '73506756',
  :length => 8,
  :description => "Entrepreneurs have to learn how to survive. Physically and in the business world. With all the challenges and curveballs that will come your way, you have to figure out how to weather the storms, learn from failures, go out into the world and challenge yourself. Do the things others are afraid to do. Run into things instead of away from things. You'll find that there is no challenge too hard for you.")
brilliance_course = Course.create(
  :course_icon => File.open("#{Rails.root}/app/assets/images/courses/brilliance.png"),
  :intro_screenshot => File.open("#{Rails.root}/app/assets/images/courses/screenshots/brilliance.png"),
  :title => "Brilliance",
  :start_date => "2013-11-13 00:00:00",
  :end_date => "2013-11-20 00:00:00",
  :intro_vimeo => '73541311',
  :badge_vimeo => '73506165',
  :length => 15,
  :description => "You are going to do extraordinary things once you master all the superhero powers. Figure out what you stand for. Put your stake in the ground about your brand and your reputation. With vision, creativity and an idea that others can't wait to tell others about, your brilliance will inspire others to take the journey too.")

########################
# Create Assignments
########################
# Vision
video_vision_jurvetson = Assignment.create(
  :title => "Steve Jurvetson: Disruptive Innovation",
  :description => "Steve Jurvetson talks about disruptive innovation, Moore's Law, and other awesomeness.",
  :vimeo_url => '68399202',
  :category => 'video',
  :speaker_name => "Steve Jurvetston",
  :speaker_bio => "Steve Jurvetson is a Managing Director of Draper Fisher Jurvetson, where his current board responsibilities include SpaceX, Synthetic Genomics, and Tesla Motors. He ewas the founding VC investor in Hotmail, Interwoven, Kana, and NeoPhotonics. At Stanford University, he finished his BSEE in 2.5 years and graduated #1 in his class, as the Henry Ford Scholar.",
  :speaker_twitter => "dfjsteve"
  )
video_vision_yun = Assignment.create(
  :title => "Joon Yun: Futurology",
  :description => "Joon Yun talks about futurology and singularity.",
  :vimeo_url => '68399202',
  :category => 'video'
  )
video_vision_filippenko = Assignment.create(
  :title => "Alex Filippenko: Dark Energy",
  :description => "Alex Filippenko talks about Dark Energy and the Runaway Universe.",
  :vimeo_url => '64885468',
  :category => 'video'
  )
quiz_wall_street_mba = Assignment.create(
  :title => "Reading Quiz: Ender's Game",
  :description => "Reading Quiz for Ender's Game Reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
  :survey_id => 1,
  :category => 'quiz'
  )
reading_vision_startupgame = Assignment.create(
  :title => "Reading Introduction: The Startup Game",
  :description => "The Startup Game by Bill Draper",
  :order_id => 1,
  :category => 'reading',
  :vimeo_url => '73500800'
  )

# Evangelism
video_evangelism_rjohnson = Assignment.create(
  :order_id => 1,
  :title => "Ron Johnson: The Future of Retail",
  :description => "Apple Store supremo Ron Johnson talks about the Future of Retail. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
  :vimeo_url => '69349204',
  :category => 'video'
  )
video_evangelism_blecherman = Assignment.create(
  :title => "Beth Blecherman: Tech Mamas",
  :description => "Beth Blecherman talks about creating and mangaging your online persoanl brand.",
  :vimeo_url => '67785469',
  :category => 'video'
  )
video_evangelism_roizen = Assignment.create(
  :title => "Heidi Roizen: Networking",
  :description => "Heidi Roizen talks about powering up your network.",
  :vimeo_url => '71764821',
  :category => 'video'
  )
video_evangelism_hsieh = Assignment.create(
  :title => "Tony Hsieh: The City as a Startup",
  :description => "Tony Hsieh talks about the city as a startup.",
  :vimeo_url => '68396793',
  :category => 'video'
  )
assignment_evangelism_businesscards = Assignment.create(
  :title => "Assignment: Get 5 Business Cards",
  :description => "Go out and get five business cards for xyz",
  :vimeo_url => '73505706',
  :category => 'assignment'
  )
reading_evangelism_winfriends = Assignment.create(
  :title => "Reading Introduction: How to Win Friends and Influence People",
  :description => "How to Win Friends and Influence People teaches you about xyz",
  :vimeo_url => '73499500',
  :category => 'reading',
  :order_id => 1
  )


# Speed & Strength
video_speed_cassidy = Assignment.create(
  :title => "Mike Cassidy: Moving Fast",
  :description => "Mike Cassidy on Moving fast. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor.",
  :vimeo_url => '64885468',
  :category => 'video'
  )
video_speed_blank = Assignment.create(
  :title => "Steve Blank: Lean Startup",
  :description => "Steve Blank talks about running a lean startup.",
  :vimeo_url => '68391259',
  :category => 'video'
  )
video_speed_kaplan = Assignment.create(
  :title => "Jerry Kaplan: Five Biggest Mistakes Founders Make",
  :description => "Jerry Kaplan on the five biggest mistakes founders make.",
  :vimeo_url => '71766903',
  :category => 'video'
  )


# Power
video_power_chase = Assignment.create(
  :title => "Andy Chase: Investing",
  :description => "Andy Chase on Investing. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
  :vimeo_url => '34364655',
  :category => 'video'
  )
video_power_tantow = Assignment.create(
  :title => "Martin Tantow: Setting Up Your Business",
  :description => "Martin Tantow on setting up your business.",
  :vimeo_url => '66870034',
  :category => 'video'
  )
video_power_jones = Assignment.create(
  :title => "Roderick Jones: Cyber Security",
  :description => "Roderick Jones talks about cyber security.",
  :vimeo_url => '71764820',
  :category => 'video'
  )
video_power_dow = Assignment.create(
  :title => "Bryan Dow: Financing Small Cap Companies",
  :description => "Bryan Dow talks about financing small cap companies",
  :vimeo_url => '68652715',
  :category => 'video'
  )
video_power_goodson = Assignment.create(
  :title => "Peter Goodson: Art & Science of M&A",
  :description => "Peter Goodson talks about the art and science of M&A.",
  :vimeo_url => '71766901',
  :category => 'video'
  )
reading_power_wallstreet = Assignment.create(
  :title => "Reading Introduction: The Wall Street MBA",
  :description => "The Wall Street MBA by xyz",
  :vimeo_url => '73501319',
  :category => 'reading',
  :order_id => 1
  )


# Creativity
video_creativity_seelig = Assignment.create(
  :title => "Tina Seelig: Creativity",
  :description => "Tina Seelig on Creativity. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor.",
  :vimeo_url => '68399202',
  :category => 'video'
  )
reading_creativity_enders = Assignment.create(
  :title => "Reading Introduction: Ender's Game",
  :description => "Ender's Game teaches you about xyz",
  :vimeo_url => '73499498',
  :category => 'reading',
  :order_id => 1
  )

#Survival
video_survival_hodges = Assignment.create(
  :title => "Cliff Hodges: Survival",
  :description => "Cliff Hodges on survival",
  :vimeo_url => '71764820',
  :category => 'video'
  )

# Brilliance
video_brilliance_lenet = Assignment.create(
  :title => "Scott Lenet and Jon Bassett: Elevator Pitches",
  :description => "Scott Lenet and Jon Bassett give advice on elevator pitches.",
  :vimeo_url => '52574649',
  :category => 'video'
  )

# Founder
video_founder_levie = Assignment.create(
  :title => "Founder Story: Aaron Levie",
  :description => "Aaron Levie talks about starting Box. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
  :vimeo_url => '69855849',
  :category => 'founder'
  )
video_founder_bdraper = Assignment.create(
  :title => "Founder Story: Bill Draper",
  :description => "Bill Draper's Silicon Valley Story. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
  :vimeo_url => '53026683',
  :category => 'founder'
  )
video_founder_jain = Assignment.create(
  :title => "Founder Story: Naveen Jain",
  :description => "Naveen Jain talks about entrepreneurship and shares his success story.",
  :vimeo_url => '71764822',
  :category => 'founder'
  )
video_founder_flannery = Assignment.create(
  :title => "Founder Story: Matt Flannery",
  :description => "Matt Flannery talks about his experience starting Kiva.",
  :vimeo_url => '70841268',
  :category => 'founder'
  )
video_founder_buckley = Assignment.create(
  :title => "Founder Story: Josh Buckley",
  :description => "Josh Buckley talks about his experience starting Mino Monsters.",
  :vimeo_url => '73912757',
  :category => 'founder'
  )


#############################
# Add assignments to courses
#############################
# Vision
vision_course.assignments.push video_vision_jurvetson
vision_course.assignments.push video_vision_yun
vision_course.assignments.push video_vision_filippenko
vision_course.assignments.push quiz_wall_street_mba
vision_course.assignments.push reading_vision_startupgame

# Evangelism
evangelism_course.assignments.push video_evangelism_rjohnson
evangelism_course.assignments.push video_evangelism_blecherman
evangelism_course.assignments.push video_evangelism_roizen
evangelism_course.assignments.push assignment_evangelism_businesscards
evangelism_course.assignments.push reading_evangelism_winfriends

# Speed & Strength
speed_course.assignments.push video_speed_cassidy
speed_course.assignments.push video_speed_blank
speed_course.assignments.push video_speed_kaplan

# Power
power_course.assignments.push video_power_chase
power_course.assignments.push video_power_tantow
power_course.assignments.push video_power_jones
power_course.assignments.push video_power_dow
power_course.assignments.push video_power_goodson
power_course.assignments.push reading_power_wallstreet

# Creativity
creativity_course.assignments.push video_creativity_seelig
creativity_course.assignments.push reading_creativity_enders

# Brilliance
brilliance_course.assignments.push video_brilliance_lenet

# Founder
speed_course.assignments.push video_founder_levie
vision_course.assignments.push video_founder_bdraper
vision_course.assignments.push video_founder_buckley
evangelism_course.assignments.push video_founder_jain
creativity_course.assignments.push video_founder_flannery

