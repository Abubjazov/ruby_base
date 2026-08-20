class Questions
  attr_reader :correct_answers_count, :incorrect_answers_count

  def initialize filename
    @filename = filename
    @correct_answers_count = 0
    @incorrect_answers_count = 0
  end

  def load
    YAML.safe_load_file(@filename, symbolize_names: true)
  end

  def add_correct_answer_count
    @correct_answers_count += 1
  end

  def add_incorrect_answer_count
    @incorrect_answers_count += 1
  end

end