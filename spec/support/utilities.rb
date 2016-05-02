# Show file inputs that are hidden and replaced by a <label>
def show_hidden_file_inputs
  page.execute_script %{
    $('input[type=file]').css({
      position: 'static',
      top: '0',
      left: '0',
      display: 'block',
      clear: 'both'
    })
  }
end

def wait_until
  require 'timeout'
  Timeout.timeout(Capybara.default_max_wait_time) do
    sleep(0.1) until (value = yield)
    value
  end
end

def wait_for_ajax
  wait_until do
    page.evaluate_script('$.active') == 0
  end
end

def with_invisible_elements
  original_config_val = Capybara.ignore_hidden_elements
  Capybara.ignore_hidden_elements = false
  yield
  Capybara.ignore_hidden_elements = original_config_val
end
