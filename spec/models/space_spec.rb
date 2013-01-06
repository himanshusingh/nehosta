# == Schema Information
#
# Table name: spaces
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  name           :string(255)
#  description    :text
#  rules          :text
#  street_address :string(255)
#  locality       :string(255)
#  city           :string(255)
#  country        :string(255)
#  pincode        :integer
#  capacity       :integer
#  bedrooms       :integer
#  bathrooms      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  price          :float
#  room_type      :string(255)
#  amenities      :string(255)
#  size           :float
#  directions     :text
#

require 'spec_helper'

describe Space do
  pending "add some examples to (or delete) #{__FILE__}"
end
