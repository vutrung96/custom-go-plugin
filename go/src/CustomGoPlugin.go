package main

import (
	"io/ioutil"
	"net/http"

	"github.com/TykTechnologies/opentelemetry/trace"
	"github.com/TykTechnologies/tyk/apidef/oas"
	"github.com/TykTechnologies/tyk/ctx"

	"github.com/TykTechnologies/tyk/log"
	"github.com/TykTechnologies/tyk/user"
)

var logger = log.Get()

// Parse incoming API key
func AddFooBarHeader(rw http.ResponseWriter, r *http.Request) {
	// We create a new span using the context from the incoming request.
	_, newSpan := trace.NewSpanFromContext(r.Context(), "", "GoPlugin_first-span")

	// Ensure that the span is properly ended when the function completes.
	defer newSpan.End()

	// Set a new name for the span.
	newSpan.SetName("AddFooBarHeader Function")

	// Set the status of the span.
	newSpan.SetStatus(trace.StatusOK, "")

	// Get the api_key header
	keyID := r.Header.Get("api_key")

	// Define the org and hash algorithm
	orgID := "" // Empty string as per your example
	hashAlgorithm := "murmur128"

	// Create the JSON token string with the precise format
	jsonToken := fmt.Sprintf(`{"org":"%s","id":"%s","h":"%s"}`, orgID, keyID, hashAlgorithm)

	// Encode the JSON to base64
	base64Auth := base64.StdEncoding.EncodeToString([]byte(jsonToken))

	// Set the new Authorization header
	r.Header.Set("Authorization", base64Auth)

	// Add the X-SimpleHeader-Inject header
	r.Header.Add("X-SimpleHeader-Inject", "foo")
}

func main() {}

// This will be run during Gateway startup
func init() {
	logger.Info("--- Go custom plugin init success! ---- ")
}
