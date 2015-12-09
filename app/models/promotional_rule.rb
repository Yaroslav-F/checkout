##
## @brief      Promotional rule skeleton (abstract class)
##
class PromotionalRule < ActiveRecord::Base

  def check
    fail NotImplementedError, 'This method should be overriden and return a result of comparation with the promotional rule.'
  end
end
