# author = "Josh Buckley, Founder and CEO of MinoMonsters"
# description = "Josh talks about the importance of clear and direct communication as well as having hard conversations up front."
# title = "Have Difficult Conversations"
# track_id = Track.where(name: "LEADERSHIP").first.id

# Lesson.find_or_create_by lesson_type: "watch", video: true, description: "Have Difficult Conversations- Josh Buckley", video_author: author, video_title: title, track_id: track_id, video_uid: "135826441" 


# topic = Topic.where(name: "ATTITUDE").first
# Track.where(name: "RESOURCEFULNESS").destroy_all
persistence = Track.find_or_create_by topic_id: topic.id, name: "PERSISTENCE", icon: "persistence.svg", summary: "“Building a company means having a focused vision, and working against all odds and obstacles to achieve it.”"
resourcefulness = Track.find_or_create_by topic_id: topic.id, name: "RESOURCEFULNESS", icon: "resourcefulness.svg" , summary: "Starting a startup means figuring out creative ways to get things done no matter how difficult they may seem."

hustle = Track.where(name: "HUSTLE").first
hustle.lessons.update_all(track_id: resourcefulness.id)

Lesson.where(video_title: "Becoming an Entrepreneur").first.update_attributes track_id: persistence.id
Lesson.where(video_title: "None of this is Easy").first.update_attributes track_id: persistence.id
Lesson.where(video_author:"Nate Blecharczyk, Founder and CTO of Airbnb").first.update_attributes track_id: persistence.id



