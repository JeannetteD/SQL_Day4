class Creditcard < ActiveRecord::Base
  belongs_to(:owner)
end

total_credit_limit = owner.creditcards[0].creditlimit + owner.creditcards[1].creditlimit
end
