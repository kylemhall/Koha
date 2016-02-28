ALTER TABLE branch_item_rules         ADD COLUMN hold_fulfillment_policy_group INT(11) NULL DEFAULT NULL AFTER hold_fulfillment_policy,
      ADD FOREIGN KEY (hold_fulfillment_policy_group) REFERENCES library_groups(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE default_branch_circ_rules ADD COLUMN hold_fulfillment_policy_group INT(11) NULL DEFAULT NULL AFTER hold_fulfillment_policy,
      ADD FOREIGN KEY (hold_fulfillment_policy_group) REFERENCES library_groups(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE default_branch_item_rules ADD COLUMN hold_fulfillment_policy_group INT(11) NULL DEFAULT NULL AFTER hold_fulfillment_policy,
      ADD FOREIGN KEY (hold_fulfillment_policy_group) REFERENCES library_groups(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE default_circ_rules        ADD COLUMN hold_fulfillment_policy_group INT(11) NULL DEFAULT NULL AFTER hold_fulfillment_policy,
      ADD FOREIGN KEY (hold_fulfillment_policy_group) REFERENCES library_groups(id) ON UPDATE CASCADE ON DELETE CASCADE;
