/*
 * This file is part of MAME4iOS.
 *
 * Copyright (C) 2013 David Valdeita (Seleuco)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see <http://www.gnu.org/licenses>.
 *
 * Linking MAME4iOS statically or dynamically with other modules is
 * making a combined work based on MAME4iOS. Thus, the terms and
 * conditions of the GNU General Public License cover the whole
 * combination.
 *
 * In addition, as a special exception, the copyright holders of MAME4iOS
 * give you permission to combine MAME4iOS with free software programs
 * or libraries that are released under the GNU LGPL and with code included
 * in the standard release of MAME under the MAME License (or modified
 * versions of such code, with unchanged license). You may copy and
 * distribute such a system following the terms of the GNU GPL for MAME4iOS
 * and the licenses of the other code concerned, provided that you include
 * the source code of that other code when and as the GNU GPL requires
 * distribution of source code.
 *
 * Note that people who make modified versions of MAME4iOS are not
 * obligated to grant this special exception for their modified versions; it
 * is their choice whether to do so. The GNU General Public License
 * gives permission to release a modified version without this exception;
 * this exception also makes it possible to release a modified version
 * which carries forward this exception.
 *
 * MAME4iOS is dual-licensed: Alternatively, you can license MAME4iOS
 * under a MAME license, as set out in http://mamedev.org/
 */

#import "ListOptionController.h"
#import "OptionsController.h"

@implementation ListOptionController;


- (id)initWithStyle:(UITableViewStyle)style type:(NSInteger)typeValue list:(NSArray *)listValue{

    if(self = [super initWithStyle:style])
    {
        type = typeValue;
        list = listValue;
        switch (type) {
            case kTypeManufacturerValue:
            case kTypeDriverSourceValue:
            case kTypeCategoryValue:
                indexed = true;
                break;
                
            default:
                indexed = false;
                break;
        }
        
        if(indexed)
        {
            sections = [[NSArray arrayWithObjects:@"#", @"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil] retain];
        }
        else
        {
            sections = nil;
        }
    }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
}

- (void)viewDidUnload {
        
	[super viewDidUnload];
}

- (void)dealloc {
    
    [sections release];
    
	[super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {

    Options *op = [[Options alloc] init];
    
    switch (type) {
        case kTypeNumButtons:
            self.title = @"Number Of Buttons";
            value = op.numbuttons;
            break;
        case kTypeEmuRes:
            self.title = @"Emulated Resolution";
            value = op.emures;
            break;
        case kTypeStickType:
            self.title = @"Stick Type";
            value = op.sticktype;
            break;
        case kTypeTouchType:
            self.title = @"Input Touch Type";
            value = op.touchtype;
            break;
        case kTypeControlType:
            self.title = @"External Controller";
            value = op.controltype;
            break;
        case kTypeAnalogDZValue:
            self.title = @"Stick Touch DZ";
            value = op.analogDeadZoneValue;
            break;
        case kTypeWiiDZValue:
            self.title = @"Wii Classic DZ";
            value = op.wiiDeadZoneValue;
            break;
        case kTypeSoundValue:
            self.title = @"Sound";
            value = op.soundValue;
            break;
        case kTypeFSValue:
            self.title = @"Frame Skip";
            value = op.fsvalue;
            break;
        case kTypeOverscanValue:
            self.title = @"Overscan TV-OUT";
            value = op.overscanValue;
            break;
        case kTypeSkinValue:
            self.title = @"Skin";
            value = op.skinValue;
            break;
        case kTypeManufacturerValue:
            self.title = @"Manufacturer";
            value = op.manufacturerValue;
            break;
        case kTypeYearGTEValue:
            self.title = @"Year >=";
            value = op.yearGTEValue;
            break;
        case kTypeYearLTEValue:
            self.title = @"Year <=";
            value = op.yearLTEValue;
            break;
        case kTypeDriverSourceValue:
            self.title = @"Driver Source";
            value = op.driverSourceValue;
            break;
        case kTypeCategoryValue:
            self.title = @"Category";
            value = op.categoryValue;
            break;
        default:
            break;
    }
        
    [op release];

    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (value > 10) {
        NSIndexPath *scrollIndexPath=nil;
        if(indexed)
        {
            NSString *s = [list objectAtIndex:value];
            NSString *l = [[s substringToIndex:1] lowercaseString];
            int sec = [sections indexOfObject:l];
            NSArray *sectionArray = [list filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", [sections objectAtIndex: sec]]];
            int row = [sectionArray indexOfObject:s];
            scrollIndexPath = [NSIndexPath indexPathForRow:row inSection:sec];
        }
        else
        {
           scrollIndexPath = [NSIndexPath indexPathForRow:(value) inSection:0];

        }
        [[self tableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    Options *op = [[Options alloc] init];
    
    switch (type) {
        case kTypeNumButtons:
            op.numbuttons =value;
            break;
        case kTypeEmuRes:
            op.emures =value;
            break;
        case kTypeTouchType:
            op.touchtype =value;
            break;
        case kTypeStickType:
            op.sticktype =value;
            break;
        case kTypeControlType:
            op.controltype =value;
            break;
        case kTypeAnalogDZValue:
            op.analogDeadZoneValue =value;
            break;
        case kTypeWiiDZValue:
            op.wiiDeadZoneValue =value;
            break;
        case kTypeSoundValue:
            op.soundValue =value;
            break;
        case kTypeFSValue:
            op.fsvalue =value;
            break;
        case kTypeOverscanValue:
            op.overscanValue =value;
            break;
        case kTypeSkinValue:
            op.skinValue =value;
            break;
        case kTypeManufacturerValue:
            op.manufacturerValue =value;
            break;
        case kTypeYearGTEValue:
            op.yearGTEValue =value;
            break;
        case kTypeYearLTEValue:
            op.yearLTEValue =value;
            break;
        case kTypeDriverSourceValue:
            op.driverSourceValue =value;
            break;
        case kTypeCategoryValue:
            op.categoryValue =value;
            break;
        default:
            break;
    }
    
    [op saveOptions];
    [op release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(indexed)
        return [sections count];
    else
        return 1;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if(indexed)
       return sections;
    else
       return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    /*if(indexed)
      return [sections objectAtIndex:section];
    else*/
        return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(indexed)
    {
        NSArray *sectionArray = [list filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", [sections objectAtIndex:section]]];
        return[sectionArray count];
    }
    else
       return [list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CheckMarkCellIdentifier = @"CheckMarkCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CheckMarkCellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CheckMarkCellIdentifier] autorelease];
    }
    
    NSUInteger row = [indexPath row];
    if(indexed)
    {
        NSString *txt = [self retrieveIndexedCellText:indexPath];
        cell.textLabel.text = txt;
        cell.accessoryType = ([list indexOfObject:txt] == value) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
    else
    {
       cell.textLabel.text = [list objectAtIndex:row];
       cell.accessoryType = (row == value) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
    if(indexed)
    {
        NSInteger curr = [list indexOfObject:[self retrieveIndexedCellText:indexPath]];
        if(curr!=value) {
            value = curr;
        }
    }
    else
    {
       int row = [indexPath row];
       if (row != value) {
           value = row;
       }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView reloadData];
    
}

- (NSString *)retrieveIndexedCellText:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    NSArray *sectionArray = [list filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", [sections objectAtIndex:[indexPath section] ]]];
    return [sectionArray objectAtIndex:row];
}

@end
