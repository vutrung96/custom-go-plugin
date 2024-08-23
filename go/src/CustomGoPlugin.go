package main

import (
	"net/http"

	"github.com/TykTechnologies/opentelemetry/trace"

	"encoding/base64"
	"fmt"
	"os"

	"github.com/TykTechnologies/tyk/log"
)

var logger = log.Get()

// Parse incoming api_key header into Tyk's expected format
func ParseApiKeyIntoTykFormat(rw http.ResponseWriter, r *http.Request) {
	// We create a new span using the context from the incoming request.
	_, newSpan := trace.NewSpanFromContext(r.Context(), "", "GoPlugin_first-span")

	// Ensure that the span is properly ended when the function completes.
	defer newSpan.End()

	// Set a new name for the span.
	newSpan.SetName("AddFooBarHeader Function")

	// Set the status of the span.
	newSpan.SetStatus(trace.SPAN_STATUS_OK, "")

	// Get the api_key header
	keyID := r.Header.Get("api_key")

	// Define the org and get hash algorithm from environment variable
	orgID := "" // Empty string as per your example
	hashAlgorithm := os.Getenv("TYK_GW_HASHKEYFUNCTION")
	if hashAlgorithm == "" {
		logger.Warn("Hash algorithm is empty, defaulting to murmur128.")
		hashAlgorithm = "murmur128" // Default value if environment variable is not set
	}

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
