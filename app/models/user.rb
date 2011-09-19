class User < ActiveRecord::Base
def self.create_with_omniauth(auth)
  create! do |user|
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    user.name = auth["user_info"]["nickname"]
    user.token = auth["credentials"]["token"]
    user.secret = auth["credentials"]["secret"]
  end
end
end
