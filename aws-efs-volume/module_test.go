package test

import (
	"testing"

	"github.com/chanzuckerberg/cztack/testutil"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestEfsVolume(t *testing.T) {

	project := testutil.UniqueId()
	env := testutil.UniqueId()
	service := testutil.UniqueId()
	owner := testutil.UniqueId()

	volumeName := testutil.UniqueId()

	options := testutil.Options(
		testutil.DefaultRegion,
		map[string]interface{}{
			"project": project,
			"env":     env,
			"service": service,
			"owner":   owner,

			"volume_name": volumeName,
			"vpc_id": testutil.EnvVar(testutil.EnvVPCID),
			"subnet_ids": testutil.ListEnvVar("PRIVATE_SUBNETS"),
		},
	)

	defer terraform.Destroy(t, options)
	testutil.Run(t, options)
}
