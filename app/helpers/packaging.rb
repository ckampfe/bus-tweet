module Packaging
  # predictions:
  # [
  #  [ { :direction => "Eastbound" ... },
  #    { :direction => "Eastbound" ... } ],
  #  [ { :direction => "Westbound" ... } ]
  # ]
  def self.pack(predictions, system_time)
    preds_by_dirs = {} # ie, { :WB => [15, 20], :EB => [5, 19] }
    response = "" # ie, @account WB: 15, 20 mins EB: 5, 19 mins

    # assign buckets for each direction
    # dir_group is [{}, {}] etc.
    predictions.each do |dir_group|
      # make shortkey: ":WB", ":EB", ":NB", ":SB"
      dir_sym = short_dir(dir_group[0][:direction]).to_sym

      # create bucket if it doesn't exist
      preds_by_dirs[dir_sym] ||= []

      dir_group.each do |pred|
        arrival_time = DateTime.parse(pred[:arrival_time]).to_time
        current_time = DateTime.parse(system_time).to_time

        # minutes
        preds_by_dirs[dir_sym] << ((arrival_time - current_time).round / 60).to_s
      end
    end

    # compose tweet, joining with commas, ending with 'mins'
    preds_by_dirs.each_pair do |direction, preds|
      response += "#{direction}: #{preds.join(', ')} mins" + " "
    end

    response.strip
  end

  def self.short_dir(direction) # string
    direction[0].upcase + 'B' # string
  end
end
