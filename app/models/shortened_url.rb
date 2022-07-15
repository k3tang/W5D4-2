# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord
    validates :short_url, presence: true, uniqueness: true 
    validates :long_url, presence: true
    validates :user_id, presence: true 

    after_initialize :generate_short_url    

    def self.random_code
       short = SecureRandom::urlsafe_base64(16)
        if ShortenedUrl.exists?(short)
            short = SecureRandom::urlsafe_base64(16)
       end 
            short
    end 

    private 
    def generate_short_url
       self.short_url ||= ShortenedUrl.random_code 
    end 


end 
