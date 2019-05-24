class Commission
  attr_accessor :commission, :insurance_fee, :assistance_fee, :drivy_fee

  # 30% commission on the rental price ...
  #- half goes to the insurance
  #- 1€/day goes to the roadside assistance
  #- the rest goes to us
  def initialize(price, duration)
    @commission = (price * 0.3).to_i
    @insurance_fee = (@commission / 2).to_i
    com = @commission / 2
    @assistance_fee = 1 * duration
    com = com - duration
    @drivy_fee = com.to_i
  end

  def to_hash
    {
        insurance_fee: insurance_fee,
        assistance_fee: assistance_fee,
        drivy_fee: drivy_fee
    }
  end

  def inspect
    "Commission(object_id: #{object_id},commission: #{commission}, insurance_fee: #{insurance_fee}, assistance_fee: #{assistance_fee}, drivy_fee: #{drivy_fee})"
  end
end