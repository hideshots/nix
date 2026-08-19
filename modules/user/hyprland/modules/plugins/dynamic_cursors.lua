return {
  enabled = true,
  mode = "tilt",
  threshold = 2,
  stretch = {
    limit = 3000,
    activation = "quadratic",
    window = 100,
  },
  tilt = {
    limit = 5000,
    activation = "negative_quadratic",
    window = 150,
    full = 85,
  },
  shake = {
    enabled = false,
    threshold = 5.0,
    base = 1.0,
    speed = 3.0,
    influence = 5.0,
    limit = 12.0,
    timeout = 100,
    effects = false,
    ipc = false,
  },
  hyprcursor = {
    nearest = 1,
    enabled = true,
    resolution = 512,
    fallback = "clientside",
  },
}
